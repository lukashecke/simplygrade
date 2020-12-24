//
//  GradeItemManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import Foundation

class GradeItemManager : PersistenceManager {
    
    func addGradeItem(fromDummy dummy: GradeItemDummy) {
        addGradeItem(withSubject: dummy.subject, timeStamp: dummy.timeStamp, value: dummy.value)
    }
    
    func addGradeItem(withSubject subject: String, timeStamp : Date, value: Int16) {
        let gradeItem = GradeItem(context: managedObjectContext)
        gradeItem.subject = subject
        gradeItem.timeStamp = timeStamp
        gradeItem.value = Int16(value)
        gradeItem.timeStamp = timeStamp
        // TODO: Value Setzen und DateTime führt noch zu Exception
        saveContext()
    }
    
    func delete (gradeItem: GradeItem) {
        managedObjectContext.delete(gradeItem)
        saveContext()
    }
}
