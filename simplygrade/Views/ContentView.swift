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
    
    @State private var showAddSchoolYearView = false
    
    var body: some View {
        //        VStack {
        TabView {
            GradesListNavigationView()
                        .environmentObject(gradeItemManager)
                .tabItem {
                    Text("Startseite")
                    Image(systemName: "graduationcap")
                }
            
            SubjectsListNavigationView()
                .tabItem {
                    Text("Fächer")
                    Image(systemName: "list.bullet")
                }
            
            SchoolYearsListNavigationView()
                .environmentObject(schoolYearsManager)
                .tabItem {
                    Text("Schuljahre")
                    Image(systemName: "calendar")
                }
            
            SettingsView()
                .tabItem {
                    Text("Einstellungen")
                    Image(systemName: "gearshape")
                }
        }
        
        
        
        
        
        
        
//            .overlay(
//                VStack{
//                    Spacer()
//                        Button(action: {
//                            showAddSchoolYearView = true
//                        }){
//                            Text("Neues Schuljahr")
//                        }
//
//                        .sheet(isPresented: $showAddSchoolYearView) {
//                            AddSchoolYearView(showAddScholYearView: $showAddSchoolYearView)
//                                .environmentObject(schoolYearsManager)
//
////                                .navigationBarTitle(Text("Neues Schuljahr"))
//                        }
//                    }
//            )
        
        
        
        
        
        //        }
        //        .onAppear() {
        //            UITabBar.appearance().unselectedItemTintColor  = .none
        //        }
        
    }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView(gradeItemManager: GradeItemManager(usePreview: true))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
