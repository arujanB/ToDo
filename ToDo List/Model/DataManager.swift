//
//  DataManager.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 08.05.2023.
//

import Foundation
import UIKit

protocol DataManagerDelegate {
    func didUpdateModelList(with model: [ToDoItem])
    func didFailWithError(error: Error)
}

struct DataManager{
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var shared = DataManager()
    
    var delegate: DataManagerDelegate?
    
    func getAllItems() {
        do {
            let models = try context.fetch(ToDoItem.fetchRequest())
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
            let models = try context.fetch(ToDoItem.fetchRequest())
            delegate?.didUpdateModelList(with: models)
            getAllItems()
        }catch{
            print("Error adding data", error)
        }
    }
    
    func deleteItem(item: ToDoItem) {
        context.delete(item)
        
        do {
            try context.save()
            let models = try context.fetch(ToDoItem.fetchRequest())
            delegate?.didUpdateModelList(with: models)
            getAllItems()
        }catch{
            print("Error adding data", error)
        }
    }
    
    func updatedItem(item: ToDoItem, newName: String) {
        item.name = newName
        do{
            try context.save()
            let models = try context.fetch(ToDoItem.fetchRequest())
            delegate?.didUpdateModelList(with: models)
            getAllItems()
        }catch{
            print("Error adding data", error)
        }
    }

}
