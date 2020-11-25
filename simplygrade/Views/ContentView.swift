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
                    Image(systemName: "cart.fill") // TODO: was passendes suchen
                }
            SchoolYearsListNavigationView()
                .tabItem {
                    Text("Schuljahre")
                    Image(systemName: "building.2.fill") // TODO: was passendes suchen
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
