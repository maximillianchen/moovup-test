//
//  BundleExtension.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import Foundation

extension Bundle {
    
    static var restfulProtocol: String {
        main.infoDictionary!["rest_protocol"] as! String
    }
    
    static var apiHost: String {
        main.infoDictionary!["api_host"] as! String
    }
    
    static var apiToken: String {
        main.infoDictionary!["api_token"] as! String
    }
    
}
