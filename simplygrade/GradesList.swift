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
                GradeCell(gradeItem: gradeItem)
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
                Button("Add") {
                    showAddGradeView = true
                }
                .disabled(editMode?.wrappedValue.isEditing ?? false) // TODO: geht noch nicht?
        )
        .sheet(isPresented: $showAddGradeView, content: {
            AddGradeItemView(showAddGradeView: $showAddGradeView)
        })
    }
}


struct GradeCell: View {
    @ObservedObject var gradeItem: GradeItem
    
    var body: some View {
                HStack {
                    // TODO: geht das schöner, ja!
                    Text(String(gradeItem.value))
                    Text(gradeItem.timeStamp!, style: .date)
                    Text(gradeItem.subject!)
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
