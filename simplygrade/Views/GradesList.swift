//
//  GradesList.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct GradesListNavigationView: View {
    @State private var showAddGradeView = false
    
    var body: some View {
        NavigationView {
            GradesList(showAddGradeView: $showAddGradeView)
        }
    }
}

struct GradesList: View {
    @FetchRequest(
        entity: SchoolYear.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: false)]
    )
    private var schoolYears: FetchedResults<SchoolYear>
    @FetchRequest(
        entity: GradeItem.entity(), sortDescriptors:[NSSortDescriptor(key: "timeStamp", ascending: false)]
    )
    private var gradeItems: FetchedResults<GradeItem>
    
    @Binding var showAddGradeView: Bool
    
    @Environment(\.editMode) var editMode
    
    @EnvironmentObject var gradeItemManager: GradeItemManager
    
    @State private var selectedSchoolYear = "2020/ 21" // TODO: Korrigieren
    
    var body: some View {
        VStack {
            Picker(selection: $selectedSchoolYear, label: Text("What is your favorite color?")) {
                Text("2019/ 20").tag(0)
                Text("2020/ 21").tag(1)
                Text("2021/ 22").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            List {
                ForEach(gradeItems.filter{ (gradeItem: GradeItem) in
                    gradeItem.schoolYear?.name == selectedSchoolYear
                }, id: \.self) { gradeItem in
                    GradeNavigationCell(gradeItem: gradeItem)
                    //                            .listStyle(PlainListStyle())
                }
                //                    Text("\((schoolYear.gradeItems?.count)!) Noten")
            }.foregroundColor(.primary)
            
        
        .overlay(
            Text(gradeItems.count == 0 ? "1. Erstelle dein erstes Schuljahr.\n 2.Erstelle das dazugehörige Schulfach\n 3. Trage deine erste Note ein" : "")
            // TODO: Blinken? und Pfeil auf den Knopf it dem +?
        )
        //        .listStyle(DefaultListStyle())
        .listStyle(GroupedListStyle())
        //        .listStyle(InsetGroupedListStyle())
        //        .listStyle(InsetListStyle())
        //                .listStyle(PlainListStyle())
        //        .listStyle(SidebarListStyle())
        
        .navigationTitle("Übersicht") // TODO: Oder lieber Meine Noten?
        .navigationBarItems(
            leading:
                CustomEditButton()
                .disabled(gradeItems.isEmpty),
            trailing:
                Button(action: {
                    showAddGradeView = true
                }){
                    Image(systemName: "plus").imageScale(.large)
                }
                .disabled(editMode?.wrappedValue.isEditing ?? false) // TODO: geht noch nicht?
        )
        .sheet(isPresented: $showAddGradeView, content: {
            AddGradeItemView(showAddGradeView: $showAddGradeView)
                .environmentObject(gradeItemManager) // Zwingend: Bei Sheetaufruf über Sheetmodifier kann in den erstellten Views nicht auf die hier vorhandenen EnvironmentObjects zugegriffen werden, diese müssen übergeben werden
        })
        }}
}


struct GradesList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GradesList(showAddGradeView:
                        .constant(false))
                .environment(\.managedObjectContext, PersistenceController.preview.managedObjectContext)
                .environmentObject(GradeItemManager(usePreview: true))
            GradeCell(gradeItem: PersistenceController.testGraddeItem)
                .previewLayout(.sizeThatFits)
        }
    }
}