//
//  ContentView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI
//import CoreData

struct ContentView: View {
    
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
    
    var body: some View {
        List {
            ForEach(gradeItems) { gradeItem in
                GradeCell(gradeItem: gradeItem)
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    let gradeItemToDelete = gradeItems[index]
                    PersistenceController.shared.container.viewContext.delete(gradeItemToDelete)
                    try? PersistenceController.shared.container.viewContext.save()
                }
            })
            Text("Insgesamt \(gradeItems.count) Noten")
        }
        
        .navigationTitle("Meine Noten")
        .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
            showAddGradeView = true
        })
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            GradeCell(gradeItem: PersistenceController.testGraddeItem)
                .previewLayout(.sizeThatFits)

        }
    }
}

