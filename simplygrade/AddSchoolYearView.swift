//
//  AddSchoolYearView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct AddSchoolYearView: View {
    @StateObject private var newSchoolYear = SchoolYear(context: PersistenceController.shared.managedObjectContext)
    
    @State private var didDisappearWithButton = false
    
    @Binding var showAddScholYearView: Bool
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("Name")) {
                TextField("Placeholder", text: $newSchoolYear.name.toNonOptionalString())
            }
            Section(header: Text("Notes - Nur für Lernzwecke (wieder weg)")) {
                TextEditor(text: .constant("Placeholder"))
                    .frame(height: 300)
            }
        }
        .navigationBarItems(
            leading: Button("Cancel") {
                hideAddSchoolYearView(shouldSaveNewSchoolYear: false)
            },
            trailing: Button("Save") {
                hideAddSchoolYearView(shouldSaveNewSchoolYear: true)
            }
        )
    }
        .onDisappear {
            if !didDisappearWithButton {
                hideAddSchoolYearView(shouldSaveNewSchoolYear: false)
            }
        }
    }
    
    private func hideAddSchoolYearView(shouldSaveNewSchoolYear: Bool) {
        didDisappearWithButton = true
        if shouldSaveNewSchoolYear {
            PersistenceController.shared.saveContext()
        } else {
            SchoolYearsManager.shared.delete(schoolYear: newSchoolYear)
        }
        showAddScholYearView = false
    }
}

struct AddSchoolYearView_Previews: PreviewProvider {
    static var previews: some View {
        AddSchoolYearView(showAddScholYearView: .constant(true))
    }
}
