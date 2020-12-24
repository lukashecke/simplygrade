//
//  GradeCell.swift
//  simplygrade
//
//  Created by Lukas Hecke on 24.12.20.
//

import SwiftUI

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
