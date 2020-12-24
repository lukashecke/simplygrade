//
//  CustomEditButton.swift
//  simplygrade
//
//  Created by Lukas Hecke on 25.11.20.
//

import SwiftUI

struct CustomEditButton: View {
    @Environment(\.editMode) var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                editMode?.wrappedValue = isEditing ? .inactive : .active
            }
        }, label: {
//            Image(systemName: isEditing ? "pencil.circle.fill": "pencil.circle")
//                .resizable()
//                .scaledToFit()
//                .frame(height: 24)
            Text(isEditing ? "Fertig" : "Bearbeiten")
                .multilineTextAlignment(TextAlignment.leading) // TODO: Warum funktioniert nicht?
        })
    }
}

struct CustomEditButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomEditButton()
    }
}
