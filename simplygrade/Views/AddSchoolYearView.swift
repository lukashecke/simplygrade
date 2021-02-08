//
//  AddSchoolYearView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct AddSchoolYearView: View {
    private var newSchoolYear: StateObject<SchoolYear>
    
    @State private var didDisappearWithButton = false
    
    var showAddSchoolYearView: Binding<Bool>
    
    let schoolYearsManager: SchoolYearsManager
    
    init(showAddSchoolYearView: Binding<Bool>, schoolYearsManager: SchoolYearsManager) {
        self.showAddSchoolYearView = showAddSchoolYearView
        self.schoolYearsManager = schoolYearsManager
        newSchoolYear = StateObject<SchoolYear>(wrappedValue: SchoolYear(context: schoolYearsManager.managedObjectContext))
    }
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("Name")) {
                TextField("Placeholder", text: newSchoolYear.projectedValue.name.toNonOptionalString())
            }
            Section(header: Text("Notes - Nur für Lernzwecke (wieder weg)")) {
                TextEditor(text: .constant("Placeholder"))
                    .frame(height: 300)
            }
        }
        .navigationBarItems(
            leading: Button("Abbrechen") {
                hideAddSchoolYearView(shouldSaveNewSchoolYear: false)
            },
            trailing: Button("Sichern") {
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
            schoolYearsManager.saveContext()
        } else {
            schoolYearsManager.delete(schoolYear: newSchoolYear.wrappedValue)
        }
        showAddSchoolYearView.wrappedValue = false
    }
}

struct AddSchoolYearView_Previews: PreviewProvider {
    static var previews: some View {
        AddSchoolYearView(showAddSchoolYearView: .constant(true), schoolYearsManager: SchoolYearsManager(usePreview: true))
    }
}
