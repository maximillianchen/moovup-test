//
//  ContentView.swift
//  moovuptest
//
//  Created by Max on 11/9/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        
        TabView(selection: $selectedIndex) {
            NavigationStack() {
                ListView()
            }
            .tabItem {
                Label("People", systemImage: "person.fill")
            }
            .tag(0)
            
            NavigationStack() {
                MapView()
            }
            .tabItem {
                Label("Map", systemImage: "house.fill")
            }
            .tag(1)
            
        }
        
    }
}
