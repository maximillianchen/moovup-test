//
//  MapViewModel.swift
//  moovuptest
//
//  Created by Max on 14/9/2024.
//

import Foundation
import Combine

class MapViewModel: PeopleViewModel, ObjectIdentifierHashable {
    
    @Published var usersLocation = [UserLocation]()
    
    override init() {
        super.init()
        
    }
    
    func getPeopleOnMap() {
        
        if !users.isEmpty {
            
            usersLocation = users.filter { $0.location.latitude != nil && $0.location.longitude != nil }
                .compactMap {
                    UserLocation(
                        name: "\($0.name.first) \($0.name.last)",
                        latitude: $0.location.latitude ?? 0,
                        longitude: $0.location.longitude ?? 0
                    )
                }
            
        }
        
    }
    
}
