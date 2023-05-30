//
//  DataManager.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 08.05.2023.
//

import Foundation
import UIKit

protocol ItemManagerDelegate {
    func didUpdateModelList(with model: [ToDoItem])
    func didFailWithError(error: Error)
}

struct ItemManager{
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var shared = ItemManager()
    
    var delegate: ItemManagerDelegate?
    
    func getAllItems(with text: String = "") {
        do {
            let request = ToDoItem.fetchRequest()
            
            //HELP TO WORK WITH SEARCH BAR
            if text != "" {
                let predicate = NSPredicate(format: "name CONTAINS %@", text)
                request.predicate = predicate
            }
            //till here
            
            //TO SORT THE LIST
            let desc = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [desc]
            //
            
//            let models = try context.fetch(ToDoItem.fetchRequest())
            let models = try context.fetch(request)
            delegate?.didUpdateModelList(with: models)
        }catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func createItem(with name: String) {
        let newItem = ToDoItem(context: context) //creat the newItem constant class ToDoItem and context is mean get access to save the data to local database
        newItem.name = name
        newItem.cretedAt = Date()
        do{
            try context.save()
            
            let request = ToDoItem.fetchRequest()
            //TO SORT THE LIST
            let desc = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [desc]
            
            let models = try context.fetch(request)
            delegate?.didUpdateModelList(with: models)
//            getAllItems()
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }
    
    func deleteItem(item: ToDoItem) {
        context.delete(item)
        
        do {
            try context.save()
            let models = try context.fetch(ToDoItem.fetchRequest())
            delegate?.didUpdateModelList(with: models)
//            getAllItems()
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }
    
    func updatedItem(item: ToDoItem, newName: String) {
        item.name = newName
        do{
            try context.save()
            
            let request = ToDoItem.fetchRequest()
            //TO SORT THE LIST
            let desc = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [desc]
            
            let models = try context.fetch(request)
            delegate?.didUpdateModelList(with: models)
//            getAllItems()
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }

}
