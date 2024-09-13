//
//  PeopleDetailsView.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI

struct PeopleDetailsView: View {
    
    @ObservedObject var viewModel: PeopleDetailsViewModel
    
    var body: some View {
        VStack {
            Text("user: \(viewModel.user?.name.last) \(viewModel.user?.name.first)")
        }
        .navigationBarTitle("People Details")
    }
}
