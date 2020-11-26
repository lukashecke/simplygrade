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
        Form {
            Section(header: Text("Name")) {
                TextField("Placeholder", text: Binding<String>.convertOptionalString($newSchoolYear.name))
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
