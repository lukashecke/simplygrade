//
//  GradeItemManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import Foundation

class GradeItemManager {
    
    // Singleton
    static let shared = GradeItemManager()
    private init() {}
    
    func addGradeItem(fromDummy dummy: GradeItemDummy) {
        addGradeItem(withSubject: dummy.subject, timeStamp: dummy.timeStamp, value: dummy.value)
    }
    
    func addGradeItem(withSubject subject: String, timeStamp : Date, value: Int) {
        let gradeItem = GradeItem(context: PersistenceController.shared.managedObjectContext)
        gradeItem.subject = subject
        gradeItem.timeStamp = timeStamp
        gradeItem.value = Int16(value)
        gradeItem.timeStamp = timeStamp
        // TODO: Value Setzen und DateTime führt noch zu Exception
        PersistenceController.shared.saveContext()
    }
    
    func delete (gradeItem: GradeItem) {
        PersistenceController.shared.managedObjectContext.delete(gradeItem)
        PersistenceController.shared.saveContext()
    }
}
