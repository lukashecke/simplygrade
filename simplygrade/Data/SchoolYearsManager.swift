//
//  SchoolYearsManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 01.12.20.
//

import Foundation

class SchoolYearsManager : PersistenceManager{
    func addSchoolYear(fromDummy dummy: SchoolYearDummy) {
        addSchoolYear(withSubject: dummy.name)
    }
    
    func addSchoolYear(withSubject name: String) {
        let schoolYear = SchoolYear(context: managedObjectContext)
        schoolYear.name = name
        // TODO: Value Setzen und DateTime führt noch zu Exception
        saveContext()
    }
    
    func delete (schoolYear: SchoolYear) {
        managedObjectContext.delete(schoolYear)
        saveContext()
    }
}
