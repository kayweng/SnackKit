//
//  ContractManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import ContactsUI

public typealias searchContacts = (group:NSPredicate?,contactName:String?)

public class ContactStore{
    
    public static func findContacts(_ search:searchContacts)->[CNContact]?{
        
        var retval:[CNContact]?
        let store = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
            
        case .notDetermined:
            
            store.requestAccess(for: CNEntityType.contacts, completionHandler: { (authroized:Bool, error:NSError?)-> Void in
                retval = self.retrieveContacts(store,search:search)
                } as! (Bool, Error?) -> Void)
            
            break
        case .authorized:
            retval = self.retrieveContacts(store, search: search)
            
        case .denied: break
        //Access denied, return nil
        case .restricted: break
            //Access retricted, return nil
        }
        
        return retval
    }
    
    fileprivate static func retrieveContacts(_ store:CNContactStore,search:searchContacts)->[CNContact]{
        
        var contacts:[CNContact] = []
        var allContainers: [CNContainer] = []
        
        let CNKeys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName),
                      CNContactEmailAddressesKey,
                      CNContactPhoneNumbersKey] as [Any]
        
        do {
            allContainers = try store.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try store.unifiedContacts(matching: fetchPredicate, keysToFetch: CNKeys as! [CNKeyDescriptor])
                contacts.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        return contacts
    }
}
