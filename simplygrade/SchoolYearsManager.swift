//
//  SchoolYearsManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 01.12.20.
//

import Foundation

class SchoolYearsManager: PersistenceManager {
    
    func delete(schoolYear: SchoolYear) {
        managedObjectContext.delete(schoolYear)
        saveContext()
    }
}
