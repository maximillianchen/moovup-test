//
//  ModalModifier.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI

struct ModalModifier<ModalContent>: ViewModifier where ModalContent: View {
    @Binding var isPresented: Bool
    let dimsBackground: Bool
    let transition: AnyTransition
    let animation: Animation
    @ViewBuilder let modalContent: () -> ModalContent
    
    @State var id = UUID()
    @EnvironmentObject var providerViewModel: ModalPresentationProviderViewModel
    
    func body(content: Content) -> some View {
        content
            .onDistinct([isPresented]) { _ in
                updateVisibility(isPresented)
            }
            .onAppear {
                updateVisibility(isPresented)
            }
            .onDisappear {
                updateVisibility(false)
            }
    }
    
    func updateVisibility(_ isPresented: Bool) {
        providerViewModel.merge(
            id: id,
            isPresented: isPresented,
            content: modalContent,
            dimsBackground: dimsBackground,
            transition: transition,
            animation: animation
        )
    }
}

extension View {
    func navigationModal<Content>(
        isPresented: Binding<Bool>,
        dimsBackground: Bool,
        transition: AnyTransition,
        animation: Animation,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(ModalModifier(
            isPresented: isPresented,
            dimsBackground: dimsBackground,
            transition: transition,
            animation: animation,
            modalContent: content
        ))
    }
}
