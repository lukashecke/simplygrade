//
//  ContentView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext: NSManagedObjectContext
    
    @FetchRequest(
        entity: GradeItem.entity(), sortDescriptors:[NSSortDescriptor(key: "timeStamp", ascending: true)]
    )
    var gradeItems: FetchedResults<GradeItem>
    
    @State private var showAddGradeView = false
    
    var body: some View {
        NavigationView {
            List(gradeItems) { gradeItem in
                GradeCell(gradeItem: gradeItem)
            }
            .navigationTitle("Meine Noten")
            .navigationBarItems(trailing: Button("Add") {
                showAddGradeView = true
            })
            .sheet(isPresented: $showAddGradeView, content: {
                AddGradeItemView(showAddGradeView: $showAddGradeView)
            })
        }
    }
}

struct GradeCell: View {
    @ObservedObject var gradeItem: GradeItem
    
    var body: some View {
                HStack {
                    Text("1")
//                    Text(gradeItem.timeStamp!, style: .date)
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
