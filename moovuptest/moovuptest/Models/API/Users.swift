//
//  Users.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import Foundation

typealias Users = [User]

struct User: Codable {
    let id: String
    let name: Name
    let email: String
    let picture: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, picture, location
    }
}

struct Location: Codable {
    let latitude: Double?
    let longitude: Double?
}

struct Name: Codable {
    let last, first: String
}
