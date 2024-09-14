//
//  AppDelegate.swift
//  moovuptest
//
//  Created by Max on 14/9/2024.
//

import Foundation
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        GMSServices.provideAPIKey(Bundle.mapToken)
        
        return true
    }
}
