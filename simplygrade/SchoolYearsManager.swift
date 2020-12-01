//
//  SchoolYearsManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 01.12.20.
//

import Foundation

class SchoolYearsManager {
    static let shared = SchoolYearsManager()
    
    private init() {}
    
    func delete(schoolYear: SchoolYear) {
        PersistenceController.shared.managedObjectContext.delete(schoolYear)
        PersistenceController.shared.saveContext()
    }
}
