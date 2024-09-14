//
//  GoogleMapsView.swift
//  moovuptest
//
//  Created by Max on 14/9/2024.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    
    private let zoom: Float = 14.0
    private var latitude: CGFloat
    private var longitude: CGFloat
    private var markerTitle: String = ""
    
    init(lat: CGFloat, lon: CGFloat, name: String) {
        latitude = lat
        longitude = lon
        markerTitle = name
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.camera = camera
        
        // add marker
        let mapCenter = CLLocationCoordinate2DMake(mapView.camera.target.latitude, mapView.camera.target.longitude)
        let marker = GMSMarker(position: mapCenter)
        marker.title = markerTitle
        
        marker.map = mapView
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) { }
    
}
