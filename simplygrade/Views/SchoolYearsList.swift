//
//  SchoolYearsList.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct SchoolYearsListNavigationView: View {
    var body: some View {
        NavigationView {
            SchoolYearsList()
        }
    }
}

struct SchoolYearsList: View {
    @FetchRequest(
        entity: SchoolYear.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: false)]
    )
    private var schoolYears: FetchedResults<SchoolYear>
    
    @State private var showAddSchoolYearView = false
    
    @EnvironmentObject var schoolYearsManager: SchoolYearsManager
    var body: some View {
        List {
            ForEach(schoolYears, id: \.self) { (schoolYear: SchoolYear) in
                Text(schoolYear.name!) // TODO: ! weg
            }
        }.listStyle(PlainListStyle())
        .navigationBarItems(trailing: Button(action: {
            showAddSchoolYearView = true
        }){
            Image(systemName: "plus").imageScale(.large)
        })
        .navigationTitle("Schuljahre")
        .sheet(isPresented: $showAddSchoolYearView) {
            AddSchoolYearView(showAddScholYearView: $showAddSchoolYearView)
                .environmentObject(schoolYearsManager)
        }
    }
}

struct SchoolYearsList_Previews: PreviewProvider {
    static var previews: some View {
        SchoolYearsList()
    }
}
