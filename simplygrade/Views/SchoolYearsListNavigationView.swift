//
//  SchoolYearsListNavigationView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct SchoolYearsListNavigationView: View {
    @Binding var currentSchoolYear: SchoolYear?
    
    var body: some View {
        NavigationView {
            SchoolYearsList(currentSchoolYear: $currentSchoolYear)
        }
    }
}

struct SchoolYearsList: View {
    @FetchRequest(
        entity: SchoolYear.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    )
    private var schoolYears: FetchedResults<SchoolYear>
    
    @State private var showAddSchoolYearView = false
    
    @EnvironmentObject var schoolYearsManager: SchoolYearsManager
    
    @Binding var currentSchoolYear: SchoolYear?
    
    var body: some View {
        Form {
            Section (header: Text("Schuljahre")){
                List {
                    ForEach(schoolYears) { schoolYear in
                        SchoolYearCell(schoolYear: schoolYear)
                    }
                }
            }
            Section (header: Text("Anzeigen")){
                SchoolYearPicker(schoolYear: $currentSchoolYear)
            }
        }
        .navigationTitle("Schuljahre")
        .sheet(isPresented: $showAddSchoolYearView) {
            AddSchoolYearView(showAddSchoolYearView: $showAddSchoolYearView, schoolYearsManager: schoolYearsManager) 
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarTrailing) {
                Button(action: {
                    showAddSchoolYearView = true
                }){
                    Image(systemName: "plus").imageScale(.large)
                }
            }
        }
    }
}

struct SchoolYearCell: View {
    @ObservedObject var schoolYear: SchoolYear
    
    var body: some View {
        NavigationLink(schoolYear.name ?? "", destination: EditSchoolYearView(schoolYear: schoolYear))
    }
}

//struct SchoolYearsListNavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SchoolYearsListNavigationView(currentSchoolYear: )
//            .environment(\.managedObjectContext, PersistenceController.preview.managedObjectContext)
//            .environmentObject(SchoolYearsManager(usePreview: true))
//    }
//}
