//
//  ListView.swift
//  moovuptest
//
//  Created by Max on 12/9/2024.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        VStack {
            contentView()
        }
        .navigate(with: $viewModel.navigation)
    }
    
    @ViewBuilder func contentView() -> some View {
        if !viewModel.users.isEmpty {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(Array(viewModel.users.enumerated()), id: \.offset) { _, user in
                        
                        PeopleItemView(user: user)
                            .listRowInsets(EdgeInsets())
                            .onTapGesture {
                                viewModel.showPeopleDetails(user: user)
                            }
                    }
                }
            }
        }
    }
    
}
