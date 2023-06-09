//
//  ToDoItem+CoreDataProperties.swift
//  
//
//  Created by Aruzhan Boranbay on 06.06.2023.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var cretedAt: Date?
    @NSManaged public var name: String?
    @NSManaged public var priority: Int16
    @NSManaged public var desc: String?
    @NSManaged public var section: ToDoSection?

}
