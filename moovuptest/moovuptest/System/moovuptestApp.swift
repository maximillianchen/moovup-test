//
//  moovuptestApp.swift
//  moovuptest
//
//  Created by Max on 11/9/2024.
//

import SwiftUI

@main
struct moovuptestApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabsView(viewModel: TabsViewModel())
                .colorScheme(.light)
        }
    }
    
}
