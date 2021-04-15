//
//  GradeItemView.swift
//  simplygrade
//
//  Created by Lukas Hecke on 15.10.20.
//

import SwiftUI

struct GradeItemView: View {
    @ObservedObject var gradeItem: GradeItem
    
//    private let stringFormatter: Formatter = {
//        let numberFormatter = Formatter()
//        return numberFormatter
//    }()
    
    var body: some View {
        Form {
            Section (header: Text("Fach")){
                TextField("Kürzel", text: $gradeItem.subject.toNonOptionalString())
            }
            Section(header: Text("Schuljahr")) {
                SchoolYearPicker(schoolYear: $gradeItem.schoolYear)
                if gradeItem.schoolYear != nil {
                    // todo: weg damit
                Button("Schuljahr Verbindung aufheben") {
                    gradeItem.schoolYear = nil
                }
                .foregroundColor(.red)
                }
            }
            Section (header: Text("Sonstiges")) {
                DatePicker("Datum", selection: $gradeItem.timeStamp.toNonOptionalDate(), displayedComponents: .date)
                    .environment(\.locale, Locale.init(identifier: "de"))
                Stepper(value: $gradeItem.value, in: 1...6) {
                    Text("Note: \(gradeItem.value)")
                }
            }
            Section {
                TextField("Anmerkungen", text: $gradeItem.comments.toNonOptionalString())
            }
        }
    }
}

struct SchoolYearPicker : View {
    @FetchRequest(entity: SchoolYear.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    ) private var schoolYears: FetchedResults<SchoolYear>
    
    @Binding var schoolYear: SchoolYear? // TODO: Hier eventuell nicht optional?!!
    
    var body: some View {
        Picker("Schuljahr", selection: $schoolYear) {
            ForEach(schoolYears) { schoolYear in
                Text(schoolYear.name ?? "")
                    .tag(schoolYear as SchoolYear?) // Anzeigename übergibt die Instanz ans Binding und MUSS GENAU DER SELBE TYP SEIN WIE BINDING ALSO ZU OPTIONAL CASTEN
                }
//                .navigationBarTitle("Schuljahr")
            }
//            .navigationBarTitle("Schuljahr auswählen")
    }
}

struct AddGradeItemView: View {
//    Perfekt für diesen Case, nur nicht für CoreData...
//    @StateObject var gradeItem = GradeItem()
    
    @State private var didDisappearWithButton = false
    
    private var newGradeItem: StateObject<GradeItem>
    var showAddGradeView: Binding<Bool>
    
    let gradeItemManager: GradeItemManager
    
    init(showAddGradeView: Binding<Bool>, gradeItemManager: GradeItemManager) {
        self.showAddGradeView = showAddGradeView
        self.gradeItemManager = gradeItemManager
        newGradeItem = StateObject<GradeItem>(wrappedValue: GradeItem(context: gradeItemManager.managedObjectContext))
    }
    
    var gradeOptions = [1,2,3,4,5,6]
    
    var body: some View {
        NavigationView {
            GradeItemView(gradeItem: newGradeItem.wrappedValue)
//                Picker("Note", selection: $gradeItemDummy.value) {
//                                                ForEach(0..<gradeOptions.count) {
//                                                    Text(String(self.gradeOptions[$0]))
//                                                }
//                                            }
            
            
//            TextField("Note", text: $gradeItemDummy.value).keyboardType(.decimalPad)
        .navigationTitle("Neue Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") {
                        hideAddGradeView(shouldSaveNewGrade: false)
//                        showAddGradeView = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sichern") {
                        hideAddGradeView(shouldSaveNewGrade: true)
//                        gradeItemManager.addGradeItem(withSubject: newGradeItem.wrappedValue.subject!, schoolYear: newGradeItem.wrappedValue.schoolYear, timeStamp: newGradeItem.wrappedValue.timeStamp!, value: newGradeItem.wrappedValue.value, comments: newGradeItem.wrappedValue.comments!)
//                        showAddGradeView = false
                    }
                }
            }
        }
    }
    private func hideAddGradeView(shouldSaveNewGrade: Bool) {
        didDisappearWithButton = true
        if shouldSaveNewGrade {
            gradeItemManager.saveContext()
        } else {
            gradeItemManager.delete(gradeItem: newGradeItem.wrappedValue)
        }
        showAddGradeView.wrappedValue = false
    }
}

struct EditGradeItemView : View {
    @ObservedObject var gradeItem: GradeItem
    
    @EnvironmentObject var gradeItemManager: GradeItemManager
    
    var body: some View {
        GradeItemView(gradeItem: gradeItem)
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

//struct GradeItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddGradeItemView(showAddGradeView: .constant(false))
//            .environmentObject(GradeItemManager(usePreview: true))
//    }
//}
