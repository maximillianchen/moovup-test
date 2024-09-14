//
//  GoogleMapsView.swift
//  moovuptest
//
//  Created by Max on 14/9/2024.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    
    private let zoom: Float = 16.0
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(withLatitude: 22.2950243, longitude: 114.1714876, zoom: zoom)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.camera = camera
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) { }
    
}
