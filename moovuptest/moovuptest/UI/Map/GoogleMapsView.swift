//
//  GoogleMapsView.swift
//  moovuptest
//
//  Created by Max on 14/9/2024.
//

import SwiftUI
import GoogleMaps

struct UserLocation: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
}

struct GoogleMapsView: UIViewRepresentable {
    
    private let zoom: Float = 12.0
    
    private var usersLocation: [UserLocation] = []
    
    init(usersLocation: [UserLocation]) {
        self.usersLocation = usersLocation
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(
            withLatitude: usersLocation.first?.latitude ?? 0,
            longitude: usersLocation.first?.longitude ?? 0,
            zoom: zoom
        )
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.camera = camera
        
        // Add marker
        if !usersLocation.isEmpty {
            usersLocation.forEach {
                let location = CLLocationCoordinate2DMake($0.latitude, $0.longitude)
                // print("location: \(location)")
                let marker = GMSMarker(position: location)
                marker.title = $0.name
                marker.map = mapView
            }
        }
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) { }
    
}
