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
        entity: SchoolYear.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    )
    private var schoolYears: FetchedResults<SchoolYear>
    
    var body: some View {
        List {
            ForEach(schoolYears) { schoolYear in
                Text(schoolYear.name ?? "")
            }
        }
        .navigationTitle("Schuljahre")
    }
}

struct SchoolYearsList_Previews: PreviewProvider {
    static var previews: some View {
        SchoolYearsList()
    }
}
