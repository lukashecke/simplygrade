//
//  GradeItemsListNavigationView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct GradeItemsListNavigationView: View {
    @State private var showAddGradeView = false
    
    @Binding var currentSchoolYear: SchoolYear?
    
    var body: some View {
    NavigationView {
        GradesList(showAddGradeView: $showAddGradeView, currentSchoolYear: $currentSchoolYear)
    }
    }
}

struct GradesList: View {
    @FetchRequest(
        entity: GradeItem.entity(), sortDescriptors:[NSSortDescriptor(key: "timeStamp", ascending: false)]
    )
    private var gradeItems: FetchedResults<GradeItem>
    
    @Binding var showAddGradeView: Bool
    
    @Binding var currentSchoolYear: SchoolYear?
    
    @Environment(\.editMode) var editMode
    
    @EnvironmentObject var gradeItemManager: GradeItemManager
    
    var body: some View {
        let currentGradeItems = gradeItems.filter {$0.schoolYear?.name == currentSchoolYear?.name}
        
        List {
            ForEach(currentGradeItems) { gradeItem in
                GradeNavigationCell(gradeItem: gradeItem)
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    let gradeItemToDelete = currentGradeItems[index]
                    gradeItemManager.delete(gradeItem: gradeItemToDelete)
                }
            })
            Text("Insgesamt \(currentGradeItems.count) Noten")
        }
        // TODO: Überlegen, ob PlainListStyle
//        .listStyle(PlainListStyle())
        .navigationTitle(currentSchoolYear?.name ?? "Noch kein Schuljahr erstellt") // TODO: Defaultmäßig soll aktuellstes Schuljahr!!
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomEditButton()
                    .disabled(gradeItems.isEmpty)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                AddGradeItemButton(showAddGradeView: $showAddGradeView)
            }
        }
        .sheet(isPresented: $showAddGradeView, content: {
            AddGradeItemView(showAddGradeView: $showAddGradeView, gradeItemManager: gradeItemManager)
                .environmentObject(gradeItemManager) // Zwingend: Bei Sheetaufruf über Sheetmodifier kann in den erstellten Views nicht auf die hier vorhandenen EnvironmentObjects zugegriffen werden, diese müssen übergeben werden
        })
    }
}

struct GradeNavigationCell: View {
    let gradeItem: GradeItem
    
    var body: some View {
        NavigationLink(destination: EditGradeItemView(gradeItem: gradeItem)) {
            GradeCell(gradeItem:  gradeItem)
        }
    }
}

struct GradeCell: View {
    @ObservedObject var gradeItem: GradeItem
    
    var body: some View {
        HStack {
            Text(gradeItem.subject ?? "")
                .font(.title)
            VStack(alignment: .leading) {
                // TODO: dynamisieren
                Text("Schulaufgabe")
                Text(gradeItem.timeStamp ?? Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .environment(\.locale, Locale.init(identifier: "de"))
        }
            Spacer()
            Text(String(gradeItem.value))
                .font(.title)
        }
    }
}

//struct GradeItemsListNavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            GradeItemsListNavigationView()
//            .environment(\.managedObjectContext, PersistenceController.preview.managedObjectContext)
//            .environmentObject(GradeItemManager(usePreview: true))
//            GradeCell(gradeItem: PersistenceController.testGraddeItem)
//                .previewLayout(.sizeThatFits)
//        }
//    }
//}
