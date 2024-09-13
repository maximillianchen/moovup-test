//
//  ModalPresentationProvider.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI

struct ModalPresentationProvider<Content>: View where Content: View {
    @ViewBuilder let content: () -> Content
    
    @StateObject var viewModel = ModalPresentationProviderViewModel()
    @State var isViewDismissing: Binding<Bool> = .constant(false)

    var body: some View {
        ZStack {
            content()
                .environmentObject(viewModel)
            
            ZStack {
                ForEach(Array(viewModel.presentationItems.enumerated()), id: \.element.id) { enumeratedItem in
                    if enumeratedItem.element.dimsBackground {
                        Color.black
                            .ignoresSafeArea()
                            .opacity(0.5)
                            .transition(.opacity)
                            .zIndex(Double(enumeratedItem.offset) * 2)
                            .onTapGesture {}
                    }
                    
                    ModalPresentationProvider<AnyView>(content: {
                        AnyView(
                            enumeratedItem.element.content()
                        )
                    }, isViewDismissing: .constant(true))
                    .transition(enumeratedItem.element.transition)
                    // https://stackoverflow.com/a/58512696
                    .zIndex(Double(enumeratedItem.offset) * 2 + 1)
                }
            }
        }
        .colorScheme(.light)
    }
}
