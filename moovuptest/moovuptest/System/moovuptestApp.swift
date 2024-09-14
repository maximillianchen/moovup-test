//
//  moovuptestApp.swift
//  moovuptest
//
//  Created by Max on 11/9/2024.
//

import SwiftUI

@main
struct moovuptestApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ModalPresentationProvider {
                TabsView(viewModel: TabsViewModel())
                    .colorScheme(.light)
            }
        }
    }
    
}
