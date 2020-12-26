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
    var schoolYear = SchoolYear()
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
            GradeItemView(subject: $gradeItemDummy.subject, timeStamp: $gradeItemDummy.timeStamp, value: $gradeItemDummy.value, schoolYear: $gradeItemDummy.schoolYear)
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
                        // TODO: Speicherknopf nur aktifiert, wenn die Form passt
                    }
                )
        }
    }
}

struct EditGradeItemView : View {
    @ObservedObject var gradeItem: GradeItem
    
    @EnvironmentObject var gradeItemManager: GradeItemManager
    
    var body: some View {
        GradeItemView(subject: $gradeItem.subject.toNonOptionalString(), timeStamp: $gradeItem.timeStamp.toNonOptionalDate(), value: $gradeItem.value, schoolYear: $gradeItem.schoolYear.toNonOptionalValue(fallback: SchoolYear()))
            .navigationTitle("Note bearbeiten")
            .onDisappear {
                gradeItemManager.saveContext()
            }
    }
}


struct GradeItemView: View {
    @Binding var subject: String
    @Binding var timeStamp: Date
    @Binding var value: Int16
    @Binding var schoolYear: SchoolYear
    
    @FetchRequest(
        entity: SchoolYear.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: false)]
    )
    private var schoolYears: FetchedResults<SchoolYear>
    
    var body: some View {
        Form {
            Picker(selection: $schoolYear, label: Text("Fach"), content: {
                
                // TODO: Schaut noch nicht aus wie es soll
                List() {
                    Text("AP")
                    Text("VS")
                    Text("IT")
                }
                
                
                
                
//                Button(action: {
//                    //                    showAddSchoolYearView = true
//                }){
//                    Text("+ Neues Unterrichtsfach")
//                }
                
                
                
                
                
                
                
//                .sheet(isPresented: $showAddSchoolYearView) {
//                    AddSchoolYearView(showAddScholYearView: $showAddSchoolYearView)
//                        .environmentObject(schoolYearsManager)
                        
//                                .navigationBarTitle(Text("Neues Schuljahr"))
//                }
                
                
                
                // TODO: Datenbank erstellen und dynamisch gestalten
//                if(schoolYears.count != 0) {
//                    ForEach(schoolYears, id: \.self) { (schoolYear: SchoolYear) in
//                        Text(schoolYear.name!) // TODO: ! weg
//                    }
//                } else {
//                    Text("Noch kein Schuljahr eingetragen")
//                }
                
                
            })
            
            
//            TextField("Fach", text: $subject)
            DatePicker("Datum", selection: $timeStamp, displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: "de"))
            Stepper(value: $value, in: 1...6) {
                Text("Note: \(value)")
            }
            Picker(selection: $schoolYear, label: Text("Schuljahr"), content: {
                if(schoolYears.count != 0) {
                    ForEach(schoolYears, id: \.self) { (schoolYear: SchoolYear) in
                        Text(schoolYear.name!) // TODO: ! weg
                    }
                } else {
                    Text("Noch kein Schuljahr eingetragen")
                }
                
                
            })
            if(schoolYears.count == 0) {
                Section {
                    Text("Sie haben noch keine eingetragene Schuljahre!").foregroundColor(.red)
                    // TODO: Sichern verhindern, außerdem das Formular überprüfund un dann speichern erst zulassen
                }
            }
        }
        
    }
}

struct AddGradeView_Previews: PreviewProvider {
    static var previews: some View {
        AddGradeItemView(showAddGradeView: .constant(false))
            .environmentObject(GradeItemManager(usePreview: true))
    }
}
