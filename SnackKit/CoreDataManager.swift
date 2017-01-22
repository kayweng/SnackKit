//
//  CoreDataManager.swift
//  SnackKit
//
//  Created by kay weng on 20/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import UIKit
import CoreData

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


public class CoreDataManager: NSObject{
    
    public var store: AppCoreData!;
    
    public class var shared : CoreDataManager{
        
        struct Static {
            static var instance:CoreDataManager? = nil
        }
        
        if Static.instance == nil{
            Static.instance = CoreDataManager()
        }
        
        return Static.instance!
    }
    
    override init(){
        super.init()
        self.store = AppCoreData();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    //Main Object Context
    public lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.store.persistentStoreCoordinator;
        if coordinator == nil {
            return nil;
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType);
        managedObjectContext.persistentStoreCoordinator = coordinator;
        return managedObjectContext;
    }()
    
    //Background Object Context
    public lazy var backgroundContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.store.persistentStoreCoordinator
        if coordinator == nil {
            return nil;
        }
        var backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType);
        backgroundContext.persistentStoreCoordinator = coordinator;
        return backgroundContext;
    }()
    
    public lazy var classContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.store.persistentStoreCoordinator
        if coordinator == nil {
            return nil;
        }
        var backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType);
        backgroundContext.persistentStoreCoordinator = coordinator;
        return backgroundContext;
    }()
    
    //Save NSManagedObjectContext
    public func saveContext (_ context: NSManagedObjectContext) -> Bool{
        var error: NSError? = nil
        if context.hasChanges {
            do {
                try context.save()
            } catch let error1 as NSError {
                error = error1
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)");
                abort();
            }
        }
        
        return true
    }
    
    public func saveMainContext() -> Bool{
        return self.saveContext(self.managedObjectContext!)
    }
    
    public func saveBackgroundContext () {
        _ = self.saveContext( self.backgroundContext! )
    }
    
    //Call back function by saveContext, support multi-thread
    public func contextDidSaveContext(_ notification: Notification) {
        let sender = notification.object as! NSManagedObjectContext
        if sender === self.managedObjectContext {
            NSLog("******** Saved main Context in this thread")
            self.managedObjectContext!.perform {
                self.managedObjectContext!.mergeChanges(fromContextDidSave: notification);
            }
        } else if sender === self.backgroundContext {
            NSLog("******** Saved background Context in this thread")
            self.backgroundContext!.perform {
                self.backgroundContext!.mergeChanges(fromContextDidSave: notification);
            }
        }else if sender == self.classContext {
            NSLog("******** Saved Class Context in this thread")
            self.classContext!.perform {
                self.classContext!.mergeChanges(fromContextDidSave: notification);
            }
        } else {
            NSLog("******** Saved Context in other thread")
            self.backgroundContext!.perform {
                self.backgroundContext!.mergeChanges(fromContextDidSave: notification);
            }
            self.managedObjectContext!.perform {
                self.managedObjectContext!.mergeChanges(fromContextDidSave: notification);
            }
            
            self.classContext!.perform {
                self.classContext!.mergeChanges(fromContextDidSave: notification);
            }
        }
        
    }
    
    public func rollbackContext(_ context:NSManagedObjectContext){
        context.rollback()
    }
    
    //delete data
    public func deleteEntity(_ name:String)->Bool{
        let data = self.fetchData(entity: name)
        
        for obj:AnyObject in data!{
            self.managedObjectContext?.delete(obj as! NSManagedObject)
        }
        
        return true
    }
    
    public func deleteData(_ deletedObject:AnyObject)->Bool{
        
        for record in deletedObject as! [NSManagedObject]{
            self.managedObjectContext?.delete(record)
        }
        
        if !self.saveMainContext(){
            self.rollbackContext(self.managedObjectContext!)
            return false
        }
        
        return true
    }
    
    public func deleteData(_ deletedObjects:[AnyObject], in context:NSManagedObjectContext) throws -> Bool{
        
        for object in deletedObjects as! [NSManagedObject]{
            context.delete(object)
        }
        
        if !self.saveContext(context){
            self.rollbackContext(self.managedObjectContext!)
            throw CoreDataError.SaveError
        }
        
        return true
    }
    
    // MARK: - Fetching
    //Get Fetch data
    public func fetchData(   entity      :   String,
                            predicate   :   NSPredicate?=nil,
                            sorting     :   [NSSortDescriptor]?=nil,
                            properties  :   NSArray? = [],
                            groupby     :   NSArray? = [],
                            limit       :   Int? = 0,
                            offSet      :   Int? = 0
        )->[AnyObject]?{
        
        var retval:[AnyObject]?
        
        if !entity.isEmpty{
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sorting
            fetchRequest.fetchLimit = limit!
            fetchRequest.fetchOffset = offSet!
            fetchRequest.returnsObjectsAsFaults = false
            
            if properties?.count > 0{
                
                fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
                fetchRequest.propertiesToFetch = properties! as [AnyObject]
                
                if let g = groupby {
                    fetchRequest.propertiesToGroupBy = g as [AnyObject]
                }
                
                retval = try! self.managedObjectContext!.fetch(fetchRequest) as! [DictionaryResult] as [AnyObject]?
            }else{
                
                fetchRequest.resultType = NSFetchRequestResultType()
                
                retval = try! self.managedObjectContext!.fetch(fetchRequest) as! [NSManagedObject]
            }
        }
        
        return retval!
    }
    
    public func fetchData(  context moc : NSManagedObjectContext,
                            entity     :   String,
                            predicate   :   NSPredicate?=nil,
                            sorting     :   [NSSortDescriptor]?=nil,
                            properties  :   NSArray? = [],
                            groupby     :   NSArray? = [],
                            limit       :   Int? = 0,
                            offSet      :   Int? = 0
        ) throws ->[AnyObject]?{
        
        var retval:[AnyObject]?
        
        if !entity.isEmpty{
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sorting
            fetchRequest.fetchLimit = limit!
            fetchRequest.fetchOffset = offSet!
            fetchRequest.returnsObjectsAsFaults = false
            
            if properties?.count > 0{
                
                fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
                fetchRequest.propertiesToFetch = properties! as [AnyObject]
                
                if let g = groupby {
                    fetchRequest.propertiesToGroupBy = g as [AnyObject]
                }
                
                retval = try! moc.fetch(fetchRequest) as! [DictionaryResult] as [AnyObject]?
            }else{
                
                fetchRequest.resultType = NSFetchRequestResultType()
                
                retval = try! moc.fetch(fetchRequest) as! [NSManagedObject]
            }
            
            guard let _ = retval else {
                throw CoreDataError.ReadError
            }
        }
        
        return retval!
    }
    
    
    //Get Fetch Count
    public func getEntityCount(_ entity:String, filter predicate:NSPredicate?)->Int{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        fetchRequest.predicate = predicate
        
        return try! self.managedObjectContext!.count(for: fetchRequest)
        
    }
    
    public func getEntityCount(_ entity:String, filter predicate:NSPredicate?, in context:NSManagedObjectContext)->Int{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        fetchRequest.predicate = predicate
        
        return try! context.count(for: fetchRequest)
    }
    
    //Get Entity Context Description
    public func insertNewObject(forEntityName name:String)->AnyObject{
        
        let entity_description:AnyObject = NSEntityDescription.insertNewObject(forEntityName: name, into: self.managedObjectContext!)
        
        return entity_description
    }
    
    public func insertNewObject(forEntityName name:String, in context:NSManagedObjectContext)->AnyObject{
        
        let entity_description:AnyObject = NSEntityDescription.insertNewObject(forEntityName: name, into: context)
        
        return entity_description
    }
    
    //clone moc object
    public func clonedManagedObject(source:NSManagedObject,entity:String)->AnyObject{
        
        let cloned:NSManagedObject = self.insertNewObject(forEntityName: entity, in: self.classContext!) as! NSManagedObject
        
        //Loop attributes, and clone values
        let attributes = source.entity.attributesByName as [String: NSAttributeDescription]
        
        for attributeName in attributes.keys{
            cloned.setValue(source.value(forKey: attributeName), forKey: attributeName)
        }
        
        //        //Loop through all relationships, and clone rel values.
        //        let relationships = source.entity.relationshipsByName as [String: NSRelationshipDescription]
        //
        //        for (key,_) in relationships{
        //
        //            if let _ = source.valueForKey(key){
        //                cloned.setValue(source.valueForKey(key), forKey: key)
        //            }
        //        }
        
        return cloned
    }
}
