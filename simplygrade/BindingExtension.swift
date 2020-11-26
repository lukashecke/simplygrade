//
//  BindingExtension.swift
//  simplygrade
//
//  Created by Lukas Hecke on 26.11.20.
//

import SwiftUI

extension Binding {
    
    static func convertOtionalValue<T>(_ optionalValue: Binding<T?>, fallback: T) -> Binding<T> {
        Binding<T>(get: {
            optionalValue.wrappedValue ?? fallback
        }, set: {
            optionalValue.wrappedValue = $0
        })
    }
    
    static func convertOptionalString(_ optionalString: Binding<String?>, fallback: String = "") ->
        Binding<String> {
            Binding<String>.convertOtionalValue(optionalString, fallback: fallback)
        }
    
    
static func convertOptionalDate(_ optionalDate: Binding<Date?>, fallback: Date = Date()) ->
    Binding<Date> {
    Binding<Date>.convertOtionalValue(optionalDate, fallback: fallback)
}
    
}
