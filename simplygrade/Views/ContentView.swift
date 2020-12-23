//
//  ContentView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI
//import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            GradesListNavigationView()
                .tabItem {
                    Text("Noten")
                    Image(systemName: "doc.plaintext") // TODO: was passendes suchen
                } // .listStyle(InsetGroupedListStyle())
            SchoolYearsListNavigationView()
                .tabItem {
                    Text("Schuljahre")
                    Image(systemName: "calendar") // TODO: was passendes suchen
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
