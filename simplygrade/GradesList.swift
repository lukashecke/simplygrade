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
        entity: GradeItem.entity(), sortDescriptors:[NSSortDescriptor(key: "timeStamp", ascending: true)]
    )
    private var gradeItems: FetchedResults<GradeItem>
    
    @Binding var showAddGradeView: Bool
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List {
            ForEach(gradeItems) { gradeItem in
                GradeNavigationCell(gradeItem: gradeItem)
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    let gradeItemToDelete = gradeItems[index]
                    GradeItemManager.shared.delete(gradeItem: gradeItemToDelete)
                }
            })
            Text("Insgesamt \(gradeItems.count) Noten")
        }
        
        .navigationTitle("Meine Noten")
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

struct GradesList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        GradesList(showAddGradeView:
            .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            GradeCell(gradeItem: PersistenceController.testGraddeItem)
                .previewLayout(.sizeThatFits)
        }
    }
}
