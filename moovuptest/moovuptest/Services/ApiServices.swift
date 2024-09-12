//
//  ApiServices.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import Foundation
import Combine
import Alamofire

protocol ApiServicesProtocol {
    func getUsers() -> AnyPublisher<Users, AFError>
}

class ApiServices: ApiServicesProtocol {
    
    init() {
        
    }
    
    func getUsers() -> AnyPublisher<Users, AFError> {
        
        let url = URL(string: "\(Bundle.restfulProtocol)://\(Bundle.apiHost)/templates/-xdNcNKYtTFG/data")!
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization": "bearer \(Bundle.apiToken)"
        ]
        
        return AF.request(url, method: .get, headers: headers)
            .validate()
            .publishDecodable(type: Users.self)
            .value()
            .eraseToAnyPublisher()
    }
    
}
