//
//  View+Extension.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI
import Combine

private struct DistinctValueModifier: ViewModifier {
    typealias Value = [AnyHashable]
    
    let value: Value
    let action: (Value) -> Void
    
    @State var currentValue: Value?
    
    func body(content: Content) -> some View {
        
        content
            .onReceive(Just(value)) {
                currentValue = $0
            }
            .onChange(of: currentValue) {
                if let value = $0 {
                    action(value)
                }
            }
    }
}

extension View {
    func onDistinct(_ value: [AnyHashable], perform action: @escaping ([AnyHashable]) -> Void) -> some View {
        modifier(DistinctValueModifier(value: value, action: action))
    }
}
