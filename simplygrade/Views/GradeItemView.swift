//
//  GradeItemView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI

struct GradeItemView: View {
    @Binding var subject: String
    @Binding var timeStamp: Date
    @Binding var value: Double
    @Binding var comments: String
    
//    private let stringFormatter: Formatter = {
//        let numberFormatter = Formatter()
//        return numberFormatter
//    }()
    
    var body: some View {
        Form {
            Section{
            TextField("Fach", text: $subject)
            DatePicker("Datum", selection: $timeStamp, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "de"))
            Stepper(value: $value, in: 1...6) {
                Text("Note: \(value)")
            }
            }
            Section {
                TextField("Anmerkungen", text: $comments)
            }
    }
}
}


// Quasi Default der beim Cancel automatisch verworfen wird
struct GradeItemDummy {
    var subject = "Fach"
    var timeStamp = Date()
    var value: Double = 1
    var comments = "Anmerkungen"
}

struct AddGradeItemView: View {
//    Perfekt für diesen Case, nur nicht für CoreData...
//    @StateObject var gradeItem = GradeItem()
    
    
    
    @State private var gradeItemDummy = GradeItemDummy()
    
    @Binding var showAddGradeView: Bool
    
    @EnvironmentObject var gradeItemManager: GradeItemManager
    
    var gradeOptions = [1,2,3,4,5,6]
    
    var body: some View {
        NavigationView {
            GradeItemView(
                subject: $gradeItemDummy.subject,
                timeStamp: $gradeItemDummy.timeStamp,
                value: $gradeItemDummy.value,
                comments: $gradeItemDummy.comments
            )
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
                gradeItemManager.addGradeItem(fromDummy: gradeItemDummy)
                showAddGradeView = false
            }
        )
        }
    }
}

struct EditGradeItemView : View {
    @ObservedObject var gradeItem: GradeItem
    
    @EnvironmentObject var gradeItemManager: GradeItemManager
    
    var body: some View {
        GradeItemView(
            subject: $gradeItem.subject.toNonOptionalString(),
            timeStamp: $gradeItem.timeStamp.toNonOptionalDate(),
            value: $gradeItem.value,
            comments: $gradeItem.comments.toNonOptionalString())
        .navigationTitle("Note bearbeiten")
        .onDisappear {
            gradeItemManager.saveContext()
        }
    }
}

struct AddGradeItemButton: View {
    @Binding var showAddGradeView: Bool
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        Button(action: {
            showAddGradeView = true
        }){
            Image(systemName: "plus").imageScale(.large)
        }
        .disabled(editMode?.wrappedValue.isEditing ?? false)
    }
}

struct GradeItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddGradeItemView(showAddGradeView: .constant(false))
            .environmentObject(GradeItemManager(usePreview: true))
    }
}
