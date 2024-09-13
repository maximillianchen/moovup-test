//
//  PeopleViewModel.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import Foundation
import Combine
import Alamofire

class PeopleViewModel: ObservableObject {
    
    var cancelBag = Set<AnyCancellable>()
    
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
    
}
