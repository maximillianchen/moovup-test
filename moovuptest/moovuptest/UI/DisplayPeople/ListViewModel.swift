//
//  ListViewModel.swift
//  moovuptest
//
//  Created by Max on 14/9/2024.
//

import Foundation
import Combine

class ListViewModel: PeopleViewModel, ObjectIdentifierHashable {
    
    @Published var navigation: Navigation?
    
    override init() {
        super.init()
        
    }
    
    func showPeopleDetails(user: User) {
        navigation = .init(
            action: .fullScreenCover(config: .init(isStacked: true)),
            targetViewModel: .peopleDetails(viewModel: .init(user: user))
        )
    }
    
}
