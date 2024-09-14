//
//  MapView.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import SwiftUI
import GoogleMaps

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        VStack {
            if !viewModel.usersLocation.isEmpty {
                VStack {
                    GoogleMapsView(usersLocation: viewModel.usersLocation)
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                }
            }
        }
        .onAppear {
            viewModel.getPeopleOnMap()
        }
    }
    
}
