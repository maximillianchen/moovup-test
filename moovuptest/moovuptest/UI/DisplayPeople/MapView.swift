//
//  MapView.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import SwiftUI
import GoogleMaps

struct MapView: View {
    
    @State private var totalDistance: CLLocationDistance = 0.0
    
    var body: some View {
        VStack {
            
            VStack {
                GoogleMapsView()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
    
}
