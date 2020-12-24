//
//  PersistenceManager.swift
//  simplygrade
//
//  Created by Lukas Hecke on 24.12.20.
//

import CoreData

/**
 Diese Klasse ermöglicht den wechsel zwischen dem ManagedObjectContext zwischen der Hauptapplikation und dem für das Preview benötgte
*/
class PersistenceManager: ObservableObject {
   var managedObjectContext: NSManagedObjectContext
   
   init(usePreview: Bool = false) {
       self.managedObjectContext = usePreview ?
           PersistenceController.preview.managedObjectContext :
           PersistenceController.shared.managedObjectContext
   }
   
   func saveContext() {
       try? managedObjectContext.save()
   }
}
