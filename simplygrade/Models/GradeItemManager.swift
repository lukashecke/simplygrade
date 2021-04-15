//
//  GradeItemManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import Foundation

class GradeItemManager : PersistenceManager {
    
    func addGradeItem(withSubject subject: String, schoolYear: SchoolYear?, timeStamp : Date, value: Double, comments: String) {
        let gradeItem = GradeItem(context: managedObjectContext)
        gradeItem.subject = subject
        gradeItem.schoolYear = schoolYear
        gradeItem.timeStamp = timeStamp
        gradeItem.value = value
        gradeItem.comments = comments
        // TODO: Value Setzen und DateTime führt noch zu Exception
        saveContext()
    }
    
    func delete (gradeItem: GradeItem) {
        managedObjectContext.delete(gradeItem)
        saveContext()
    }
}
