//
//  ModalPresentationProviderViewModel.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI

class ModalPresentationProviderViewModel: ObservableObject {
    @Published private(set) var presentationItems = [Item]()
    
    func merge<Content>(
        id: UUID,
        isPresented: Bool,
        content: @escaping () -> Content,
        dimsBackground: Bool,
        transition: AnyTransition,
        animation: Animation
    ) where Content: View {
        DispatchQueue.main.async {
            if isPresented {
                guard !self.presentationItems.contains(where: { $0.id == id }) else { return }
                
                withAnimation(animation) {
                    self.presentationItems.append(.init(
                        id: id,
                        content: { .init(content()) },
                        dimsBackground: dimsBackground,
                        transition: transition,
                        animation: animation
                    ))
                }
            } else {
                guard self.presentationItems.contains(where: { $0.id == id }) else { return }
                
                withAnimation(animation) {
                    self.presentationItems.removeAll { $0.id == id }
                }
            }
        }
    }
}

extension ModalPresentationProviderViewModel {
    struct Item {
        let id: UUID
        let content: () -> AnyView
        
        let dimsBackground: Bool
        let transition: AnyTransition
        let animation: Animation
    }
}
