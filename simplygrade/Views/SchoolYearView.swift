//
//  SchoolYearView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct SchoolYearView: View {
    @ObservedObject var schoolYear: SchoolYear
    
    var body: some View {
    Form {
        Section(header: Text("Name")) {
            TextField("z.B. Klasse, Jahr oder Semester", text: $schoolYear.name.toNonOptionalString())
        }
//        Section(header: Text("Notes - Nur für Lernzwecke (wieder weg)")) {
//            TextEditor(text: .constant("Placeholder"))
//                .frame(height: 300)
//        }
    }
    }
    
}

struct EditSchoolYearView: View {
    @ObservedObject var schoolYear: SchoolYear
    
    @EnvironmentObject var schoolYearManager: SchoolYearsManager
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        SchoolYearView(schoolYear: schoolYear)
            .navigationTitle("Schuljahr bearbeiten")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern") {
                        schoolYearManager.saveContext()
                        presentationMode.wrappedValue.dismiss()
                        // schoolYear.objectWillChange.send() // UI informieren -> status hat sich geändert
                    }
                    .disabled(!schoolYear.hasChanges)
                }
            }
            .onDisappear {
                if schoolYear.hasChanges {
                    schoolYearManager.managedObjectContext.refresh(schoolYear, mergeChanges: false) // was ungespeichert, wird verworfen
                }
            }
    }
}

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
            SchoolYearView(schoolYear: newSchoolYear.wrappedValue)
                .navigationTitle("Neues Schuljahr")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Abbrechen") {
                            hideAddSchoolYearView(shouldSaveNewSchoolYear: false)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Sichern") {
                            hideAddSchoolYearView(shouldSaveNewSchoolYear: true)
                        }
                    }
                }
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
