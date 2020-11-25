//
//  AddSchoolYearView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct AddSchoolYearView: View {
    @StateObject private var newSchoolYear = SchoolYear(context: PersistenceController.shared.managedObjectContext)
    
    var body: some View {
        let nameBinding = Binding<String>(get: {
            if self.newSchoolYear.name != nil {
                return self.newSchoolYear.name!
            }
            return ""
        }, set: {
            self.newSchoolYear.name = $0
        })
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: nameBinding)
            }
            Section(header: Text("Notes - Nur für Lernzwecke (wieder weg)")) {
                TextEditor(text: .constant("Placeholder"))
                    .frame(height: 300)
            }
        }
    }
}

struct AddSchoolYearView_Previews: PreviewProvider {
    static var previews: some View {
        AddSchoolYearView()
    }
}
