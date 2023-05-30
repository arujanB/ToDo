//
//  ToDoSection+CoreDataProperties.swift
//  
//
//  Created by Aruzhan Boranbay on 29.05.2023.
//
//

import Foundation
import CoreData


extension ToDoSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoSection> {
        return NSFetchRequest<ToDoSection>(entityName: "ToDoSection")
    }

    @NSManaged public var name: String?
    @NSManaged public var item: ToDoItem?

}
