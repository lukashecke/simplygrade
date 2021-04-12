//
//  ContentView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var currentSchoolYear: SchoolYear?
    
    @FetchRequest(
        entity: SchoolYear.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    )
    private var schoolYears: FetchedResults<SchoolYear>
    
    var gradeItemManager = GradeItemManager()
    
    var schoolYearsManager = SchoolYearsManager()
    
    var body: some View {
        TabView {
            GradeItemsListNavigationView(currentSchoolYear: $currentSchoolYear)
                .environmentObject(gradeItemManager)
                .tabItem {
                    Text("Noten")
                    Image(systemName: "doc.plaintext") // TODO: was passendes suchen
                } // .listStyle(InsetGroupedListStyle())
            SchoolYearsListNavigationView(currentSchoolYear: $currentSchoolYear)
                .environmentObject(schoolYearsManager)
                .tabItem {
                    Text("Schuljahre")
                    Image(systemName: "calendar") // TODO: was passendes suchen
                }
        }
        .onAppear{
            self.currentSchoolYear = schoolYears.last
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//            ContentView(
//                gradeItemManager: GradeItemManager(usePreview: true),
//                schoolYearsManager: SchoolYearsManager(usePreview: true)
//            )
//                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
