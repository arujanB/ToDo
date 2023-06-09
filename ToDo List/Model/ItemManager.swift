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
    
    func getAllItems(with text: String = "", section: ToDoSection) {
        do {
            let request = ToDoItem.fetchRequest()
            
            //HELP TO WORK WITH SEARCH BAR
            if text != "" {
                let predicateSearch = NSPredicate(format: "name CONTAINS %@", text)
//                request.predicate = predicateSearch
                
                let predicateSection = NSPredicate(format: "section == %@", section)
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateSearch, predicateSection])
            }
            //till here
            else {
                let predicateSection = NSPredicate(format: "section == %@", section)
                request.predicate = predicateSection
            }
            
            //TO SORT THE LIST
            let name = NSSortDescriptor(key: "name", ascending: true)
            let desc = NSSortDescriptor(key: "desc", ascending: true)
            request.sortDescriptors = [name, desc]
            //
            
//            let models = try context.fetch(ToDoItem.fetchRequest())
            let models = try context.fetch(request)
            delegate?.didUpdateModelList(with: models)
        }catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func createItem(name: String, description: String, priority: String, section: ToDoSection) {
        let newItem = ToDoItem(context: context) //creat the newItem constant class ToDoItem and context is mean get access to save the data to local database
        newItem.name = name
        newItem.desc = description
        newItem.priority = Int16(priority)!
        newItem.cretedAt = Date()
        section.addToItem(newItem)
//        newItem.section = section //is same in 59s line of the code
        do{
            try context.save()
            let models = try context.fetch(ToDoItem.fetchRequest())
            delegate?.didUpdateModelList(with: models)
//            getAllItems(/*section: section*/)
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }
    
    func deleteItem(item: ToDoItem, section: ToDoSection) {
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
    
    func updatedItem(item: ToDoItem, newName: String, newDesc: String/*, priority: Int16, newPriority: Int16*/, section: ToDoSection) {
        item.name = newName
        item.desc = newDesc
//        item.priority = newPriority
        do{
            try context.save()
            let models = try context.fetch(ToDoItem.fetchRequest())
            delegate?.didUpdateModelList(with: models)
//            getAllItems(/*section: section*/)
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }

}
