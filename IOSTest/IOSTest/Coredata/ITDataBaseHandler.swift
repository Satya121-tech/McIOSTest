//
//  ITDataBaseHandler.swift
//  IOSTest
//
//  Created by Satya on 10/08/19.
//  Copyright © 2019 Satya. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ITDataBaseHandler: NSObject {
    
    var responseData : [NSManagedObject] = []
    
    func saveToken(_ accessToken: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ITConstant.ENTITY_NAME,
                                       in: managedContext)!
        let response = NSManagedObject(entity: entity, insertInto: managedContext)
        response.setValue(accessToken, forKeyPath: ITConstant.ATTRIBUTE_ACCESS_TOKEN_KEY)
        
        do {
            try managedContext.save()
            responseData.append(response)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getToken() -> String? {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return ""
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: ITConstant.ENTITY_NAME)
        
        do {
            responseData = try managedContext.fetch(fetchRequest)
            
            for responseDataAttribute in responseData{
                
                guard let accessToken = responseDataAttribute.value(forKeyPath: ITConstant.ATTRIBUTE_ACCESS_TOKEN_KEY) as? String else { return nil}
                
                return accessToken
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
}
