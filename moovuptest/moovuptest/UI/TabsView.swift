//
//  TabsView.swift
//  moovuptest
//
//  Created by Max on 11/9/2024.
//

import SwiftUI

struct TabsView: View {
    
    @ObservedObject var viewModel: TabsViewModel
    
    var body: some View {
        
        TabView(selection: $viewModel.selectedtab) {
            NavigationStack() {
                ListView(viewModel: viewModel.peopleViewModel)
            }
            .tabItem {
                Label("People", systemImage: "person.fill")
            }
            .tag(Tab.list)
            
            NavigationStack() {
                MapView()
            }
            .tabItem {
                Label("Map", systemImage: "house.fill")
            }
            .tag(Tab.map)
            
        }
        
    }
}
