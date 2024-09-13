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
        contentView()
    }
    
    @ViewBuilder func contentView() -> some View {
        if let items = viewModel.users, items.count > 0 {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.offset) { _, user in
                        
                        PeopleItemView(user: user)
                            .listRowInsets(EdgeInsets())
                            .onTapGesture {
                                
                            }
                    }
                }
            }
        }
    }
    
}
