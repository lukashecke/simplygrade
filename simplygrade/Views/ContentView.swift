//
//  ContentView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI

struct ContentView: View {
    var gradeItemManager = GradeItemManager()
    
    var schoolYearsManager = SchoolYearsManager()
    
    var body: some View {
        TabView {
            GradeItemsListNavigationView()
                .environmentObject(gradeItemManager)
                .tabItem {
                    Text("Noten")
                    Image(systemName: "doc.plaintext") // TODO: was passendes suchen
                } // .listStyle(InsetGroupedListStyle())
            SchoolYearsListNavigationView()
                .environmentObject(schoolYearsManager)
                .tabItem {
                    Text("Schuljahre")
                    Image(systemName: "calendar") // TODO: was passendes suchen
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView(
                gradeItemManager: GradeItemManager(usePreview: true),
                schoolYearsManager: SchoolYearsManager(usePreview: true)
            )
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
