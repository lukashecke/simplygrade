//
//  AddSchoolYearView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct SchoolYearDummy {
    var name = "Schuljahrname"
}

struct AddSchoolYearView: View {
    @State private var schoolYearDummy = SchoolYearDummy()
    
    @State private var didDisappearWithButton = false
    
    @Binding var showAddScholYearView: Bool
    
    @EnvironmentObject var schoolYearsManager: SchoolYearsManager
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("Name")) {
                TextField("Placeholder", text: $schoolYearDummy.name)
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
            schoolYearsManager.addSchoolYear(fromDummy: schoolYearDummy)
        }
        showAddScholYearView = false
    }
}

struct AddSchoolYearView_Previews: PreviewProvider {
    static var previews: some View {
        AddSchoolYearView(showAddScholYearView: .constant(true))
            .environmentObject(SchoolYearsManager(usePreview: true))
    }
}
