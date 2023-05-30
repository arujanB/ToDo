//
//  SectionManager.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 30.05.2023.
//

import Foundation
import UIKit

protocol SectionManagerDelegate {
    func didUpdate(with model: [ToDoSection])
    func didFail(with error: Error)
}

struct SectionManager{
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var shared = SectionManager()
    
    var delegate: SectionManagerDelegate?

    func getAllSection() {
        do{
            let sectionModel = try context.fetch(ToDoSection.fetchRequest())
            delegate?.didUpdate(with: sectionModel)
        }catch {
            delegate?.didFail(with: error)
        }
    }
    
    func createSection(with text: String) {
        let sectionData = ToDoSection(context: context)
        sectionData.name = text
        
        do{
            try context.save()
            let sectionModel = try context.fetch(ToDoSection.fetchRequest())
            delegate?.didUpdate(with: sectionModel)
        }catch{
            delegate?.didFail(with: error)
        }
    }
    
    func deleteSection(with section: ToDoSection) {
        context.delete(section)
        
        do{
            try context.save()
            //getAllSection()
            let sectionModel = try context.fetch(ToDoSection.fetchRequest())
            delegate?.didUpdate(with: sectionModel)
        }catch {
            delegate?.didFail(with: error)
        }
    }
    
    func updateSection(with section: ToDoSection, to newName: String) {
        section.name = newName
        do{
            try context.save()
            let sectionModel = try context.fetch(ToDoSection.fetchRequest())
            delegate?.didUpdate(with: sectionModel)
        }catch{
            delegate?.didFail(with: error)
        }
    }
}
