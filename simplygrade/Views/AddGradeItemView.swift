//
//  AddGradeView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI

// Quasi Default der beim Cancel automatisch verworfen wird
struct GradeItemDummy {
    var subject = "Fach"
    var timeStamp = Date()
    var value = Int16(0)
}

struct AddGradeItemView: View {
//    Perfekt für diesen Case, nur nicht für CoreData...
//    @StateObject var gradeItem = GradeItem()
    
    
    
    @State private var gradeItemDummy = GradeItemDummy()
    
    @Binding var showAddGradeView: Bool
    
    var gradeOptions = [1,2,3,4,5,6]
    
    var body: some View {
        NavigationView {
            GradeItemView(subject: $gradeItemDummy.subject, timeStamp: $gradeItemDummy.timeStamp, value: $gradeItemDummy.value)
//                Picker("Note", selection: $gradeItemDummy.value) {
//                                                ForEach(0..<gradeOptions.count) {
//                                                    Text(String(self.gradeOptions[$0]))
//                                                }
//                                            }
            
            
//            TextField("Note", text: $gradeItemDummy.value).keyboardType(.decimalPad)
        .navigationTitle("Neue Note")
        .navigationBarItems(
            leading: Button("Abbrechen") {
                showAddGradeView = false
            },
            trailing: Button("Sichern") {
                GradeItemManager.shared.addGradeItem(fromDummy: gradeItemDummy)
                showAddGradeView = false
            }
        )
        }
    }
}

struct EditGradeItemView : View {
    @ObservedObject var gradeItem: GradeItem
    
    var body: some View {
        GradeItemView(subject: $gradeItem.subject.toNonOptionalString(), timeStamp: $gradeItem.timeStamp.toNonOptionalDate(), value: $gradeItem.value)
        .navigationTitle("Note bearbeiten")
        .onDisappear {
            PersistenceController.shared.saveContext()
        }
    }
}


struct GradeItemView: View {
    @Binding var subject: String
    @Binding var timeStamp: Date
    @Binding var value: Int16
    
    var body: some View {
        Form {
            TextField("Fach", text: $subject)
            DatePicker("Datum", selection: $timeStamp, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "de"))
            Stepper(value: $value, in: 1...6) {
                Text("Note: \(value)")
            }
    }
}
}

//struct AddGradeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddGradeItemView(showAddGradeView: .constant(false))
//    }
//}
