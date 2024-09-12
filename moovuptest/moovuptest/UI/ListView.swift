//
//  ListView.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel: PeopleViewModel
    
    var body: some View {
        Text("ListView User count: \(viewModel.users?.count ?? 0)")
            .onAppear {
                viewModel.fetchUsers()
            }
    }
    
}
