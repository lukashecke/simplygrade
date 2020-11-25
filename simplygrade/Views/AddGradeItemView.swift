//
//  AddGradeView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI

struct AddGradeItemView: View {
//    Perfekt für diesen Case, nur nicht für CoreData...
//    @StateObject var gradeItem = GradeItem()
    
    // Quasi Default der beim Cancel automatisch verworfen wird
    struct GradeItemDummy {
        var subject = "Fach"
        var timeStamp = Date()
        var value = "0"
    }
    
    @State private var gradeItemDummy = GradeItemDummy()
    
    @Binding var showAddGradeView: Bool
    
    var body: some View {
        NavigationView {
        Form {
            TextField("Fach", text: $gradeItemDummy.subject)
            DatePicker("Datum", selection: $gradeItemDummy.timeStamp)
            TextField("Note", text: $gradeItemDummy.value).keyboardType(.decimalPad)
        }
        .navigationTitle("Neue Note")
        .navigationBarItems(
            leading: Button("Canel") {
                showAddGradeView = false
            },
            trailing: Button("Save") {
                //TODO:  In PersistenceController?
                let gradeItem = GradeItem(context: PersistenceController.shared.container.viewContext)
                gradeItem.subject = gradeItemDummy.subject
                gradeItem.timeStamp = gradeItemDummy.timeStamp
//                // TODO das ändern und imm dummy auch schon als int
                gradeItem.value=Int16(gradeItemDummy.value)!
                try? PersistenceController.shared.container.viewContext.save()
                showAddGradeView = false
            }
        )
        }
    }
}

struct AddGradeView_Previews: PreviewProvider {
    static var previews: some View {
        AddGradeItemView(showAddGradeView: .constant(false))
    }
}
