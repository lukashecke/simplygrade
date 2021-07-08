//
//  GradeItemManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import Foundation

class GradeItemManager : PersistenceManager {
    
    func delete (gradeItem: GradeItem) {
        managedObjectContext.delete(gradeItem)
        saveContext()
    }
}
