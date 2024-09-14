//
//  TabsViewModel.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import Foundation
import Combine

enum Tab: Int {
    case list = 0
    case map = 1
}

class TabsViewModel: ObservableObject {
    
    @Published var selectedtab: Tab = .list
    
    let listViewModel: ListViewModel = .init()
    let mapViewModel: MapViewModel = .init()
    
}
