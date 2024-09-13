//
//  ObjectIdentifierHashable.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import Foundation

protocol ObjectIdentifierHashable: AnyObject, Hashable {}

extension ObjectIdentifierHashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
