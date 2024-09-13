//
//  PeopleDetailsViewModel.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import Foundation

class PeopleDetailsViewModel: ObservableObject, ObjectIdentifierHashable {
    
    @Published var user: User?
    
    init(user: User) {
        self.user = user
    }
    
}
