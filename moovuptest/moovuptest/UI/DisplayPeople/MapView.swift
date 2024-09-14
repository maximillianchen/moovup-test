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
                GoogleMapsView(lat: 22.2950243, lon: 114.1714876, name: "")
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
            }.edgesIgnoringSafeArea(.all)
            
        }
    }
    
}
