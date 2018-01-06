//
//  ContractManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import ContactsUI

public typealias ContactFilters = (group:NSPredicate?,contactName:String?)

public class ContactStore{
    
    public static func findContacts()->[CNContact]?{
        
        var retval:[CNContact]?
        let store = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
            
        case .notDetermined:
            
            store.requestAccess(for: CNEntityType.contacts, completionHandler: { (authorized, error) in
                retval = self.retrieveContacts(store)
            })
            
            break
        case .authorized:
            retval = self.retrieveContacts(store)
        default:
            retval = []
        }
        
        return retval
    }
    
    fileprivate static func retrieveContacts(_ store:CNContactStore)->[CNContact]{
        
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
