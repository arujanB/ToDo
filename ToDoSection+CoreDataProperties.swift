//
//  ToDoSection+CoreDataProperties.swift
//  
//
//  Created by Aruzhan Boranbay on 30.05.2023.
//
//

import Foundation
import CoreData


extension ToDoSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoSection> {
        return NSFetchRequest<ToDoSection>(entityName: "ToDoSection")
    }

    @NSManaged public var name: String?
    @NSManaged public var item: NSSet?

}

// MARK: Generated accessors for item
extension ToDoSection {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: ToDoItem)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: ToDoItem)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}
