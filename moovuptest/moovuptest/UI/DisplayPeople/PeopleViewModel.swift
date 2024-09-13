//
//  PeopleViewModel.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import Foundation
import Combine
import Alamofire

class PeopleViewModel: ObservableObject, ObjectIdentifierHashable {
    
    var cancelBag = Set<AnyCancellable>()
    
    @Published var navigation: Navigation?
    @Published var users: Users?
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        
        ApiServices().getUsers()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { print($0) },
                receiveValue: { [weak self] in
                    guard let self else { return }
                    self.users = $0
                    
                    print("fetchUsers_ \(self.users)")
                }
            )
            .store(in: &cancelBag)
        
    }
    
    func showPeopleDetails(user: User) {
        navigation = .init(
            action: .push,
            targetViewModel: .peopleDetails(viewModel: .init(user: user))
        )
    }
    
}
