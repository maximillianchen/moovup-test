//
//  NavigationModifier.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI

struct NavigationModifier: ViewModifier {
    @Binding var navigation: Navigation?
    var navigationWillbeNil: ((Navigation) -> Void)?
    
    @State var showsUsingPush = false
    @State var pushTargetViewModel: Navigation.TargetViewModel?
    @State var pushNavigation: Navigation?
    
    @State var showsUsingSheet = false
    @State var sheetConfig: Navigation.Action.SheetConfig?
    @State var sheetTargetViewModel: Navigation.TargetViewModel?
    @State var sheetNavigation: Navigation?
    
    @State var showsUsingFullScreenCover = false
    @State var fullScreenCoverConfig: Navigation.Action.FullScreenCoverConfig?
    @State var fullScreenCoverTargetViewModel: Navigation.TargetViewModel?
    @State var fullScreenCoverNavigation: Navigation?
    
    @State var showsUsingModal = false
    @State var modalConfig: Navigation.Action.ModalConfig?
    @State var modalTargetViewModel: Navigation.TargetViewModel?
    @State var modalNavigation: Navigation?
    
    func body(content: Content) -> some View {
        content
            .onDistinct([navigation]) { _ in
                clearState(resetConfig: navigation != nil)
                
                if let navigation = navigation {
                    handle(navigation: navigation)
                }
            }
            .modify(with: handlePush)
            .modify(with: handleSheet)
            .modify(with: handleFullScreenCover)
            .modify(with: handleModal)
    }
    
    func clearState(resetConfig: Bool = true) {
        showsUsingPush = false
        pushTargetViewModel = nil
        
        showsUsingSheet = false
        if resetConfig { sheetConfig = nil }
        sheetTargetViewModel = nil
        
        showsUsingFullScreenCover = false
        if resetConfig { fullScreenCoverConfig = nil }
        fullScreenCoverTargetViewModel = nil
        
        showsUsingModal = false
        if resetConfig { modalConfig = nil }
        modalTargetViewModel = nil
    }
    
    func handle(navigation: Navigation) {
        switch navigation.action {
        case .push:
            showsUsingPush = true
            pushTargetViewModel = navigation.targetViewModel
            pushNavigation = navigation
        case .sheet(let config):
            showsUsingSheet = true
            sheetConfig = config
            sheetTargetViewModel = navigation.targetViewModel
            sheetNavigation = navigation
        case .fullScreenCover(let config):
            showsUsingFullScreenCover = true
            fullScreenCoverConfig = config
            fullScreenCoverTargetViewModel = navigation.targetViewModel
            fullScreenCoverNavigation = navigation
        case .modal(let config):
            showsUsingModal = true
            modalConfig = config
            modalTargetViewModel = navigation.targetViewModel
            modalNavigation = navigation
        }
    }
    
    func handlePush<Content: View>(_ content: Content) -> some View {
        content
            .onDistinct([showsUsingPush]) { _ in
                if !showsUsingPush {
                    if pushNavigation == navigation && navigation != nil {
                        navigationWillbeNil?(navigation!)
                        navigation = nil
                    }
                }
            }
            .background(
                NavigationLink(isActive: $showsUsingPush) {
                    Navigation.TargetView(targetViewModel: pushTargetViewModel)
                } label: {
                    EmptyView()
                }
            )
    }
    
    func handleSheet<Content: View>(_ content: Content) -> some View {
        content
            .onDistinct([showsUsingSheet]) { _ in
                if !showsUsingSheet {
                    if sheetNavigation == navigation && navigation != nil {
                        navigationWillbeNil?(navigation!)
                        navigation = nil
                    }
                }
            }
            .sheet(isPresented: $showsUsingSheet) {
                ModalPresentationProvider {
                    if let config = sheetConfig {
                        if config.isStacked {
                            NavigationView {
                                Navigation.TargetView(targetViewModel: sheetTargetViewModel)
                            }
                            // https://stackoverflow.com/a/66024249
                            .navigationViewStyle(.stack)
                            .id(sheetTargetViewModel)
                        } else {
                            Navigation.TargetView(targetViewModel: sheetTargetViewModel)
                        }
                    }
                }
            }
    }
    
    func handleFullScreenCover<Content: View>(_ content: Content) -> some View {
        content
            .onDistinct([showsUsingFullScreenCover]) { _ in
                if !showsUsingFullScreenCover {
                    if fullScreenCoverNavigation == navigation && navigation != nil {
                        navigationWillbeNil?(navigation!)
                        navigation = nil
                    }
                }
            }
            .fullScreenCover(isPresented: $showsUsingFullScreenCover) {
                ModalPresentationProvider(content: {
                    if let config = fullScreenCoverConfig {
                        if config.isStacked {
                            NavigationView {
                                Navigation.TargetView(targetViewModel: fullScreenCoverTargetViewModel)
                            }
                            // https://stackoverflow.com/a/66024249
                            .navigationViewStyle(.stack)
                            .id(fullScreenCoverTargetViewModel)
                        } else {
                            Navigation.TargetView(targetViewModel: fullScreenCoverTargetViewModel)
                        }
                    }
                }, isViewDismissing: .constant(false))
            }
    }
    
    func handleModal<Content: View>(_ content: Content) -> some View {
        content
            .onDistinct([showsUsingModal]) { _ in
                if !showsUsingModal {
                    if modalNavigation == navigation && navigation != nil {
                        navigationWillbeNil?(navigation!)
                        navigation = nil
                    }
                }
            }
            .navigationModal(
                isPresented: $showsUsingModal,
                dimsBackground: modalConfig?.dimsBackground ?? false,
                transition: modalConfig?.transition.toAnyTransition() ?? .identity,
                animation: modalConfig?.animationDuration.toAnimation() ?? .default
            ) {
                Navigation.TargetView(targetViewModel: modalTargetViewModel)
            }
    }
}

fileprivate extension View {
    func modify<Content: View>(with block: (_ content: Self) -> Content) -> some View {
        block(self)
    }
}

extension View {
    func navigate(
        with navigation: Binding<Navigation?>,
        willBeNil: ((Navigation) -> Void)? = nil
    ) -> some View {
        modifier(NavigationModifier(
            navigation: navigation,
            navigationWillbeNil: willBeNil
        ))
    }
}
