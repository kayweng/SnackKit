//
//  CoreDataManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//
import Foundation
import CoreData

public var gCoreDataFileName = ""

public class AppCoreData: NSObject{
    
    //Directory of application uses to store the core data store file.
    lazy var applicationDocumentDirectory: URL = {
        
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask);
        
        return urls[urls.count-1]
    }()
    
    //Core data model (optional property!)
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = Bundle.main.url(forResource: gCoreDataFileName, withExtension: "momd")!;
        
        return NSManagedObjectModel(contentsOf: modelURL)!;
    }()
    
    //Presistent store coordinator for the application
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let url = self.applicationDocumentDirectory.appendingPathComponent(gCoreDataFileName)
        
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's core data."
        
        do {
            //@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES
            let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                            NSInferMappingModelAutomaticallyOption: true]
            
            try                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: mOptions)
            
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            
            var dict:[AnyHashable: Any] = [:]
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "PERSISTENT STORE", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
}
