//
//  PeopleDetailsViewModel.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import Foundation

class PeopleDetailsViewModel: ObservableObject, ObjectIdentifierHashable {
    
    @Published var user: User?
    
    @Published var imageUrl: URL?
    @Published var name: String = ""
    @Published var email: String = ""
    
    @Published var lat: CGFloat
    @Published var lon: CGFloat
    
    init(user: User) {
        self.user = user
        
        imageUrl = URL(string: user.picture)
        name = "\(user.name.last) \(user.name.first)"
        email = user.email
        
        lat = user.location.latitude ?? 0
        lon = user.location.longitude ?? 0
    }
    
}
