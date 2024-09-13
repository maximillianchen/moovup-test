//
//  Navigation+TargetView.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI

extension Navigation {
    struct TargetView: View {
        let targetViewModel: TargetViewModel?
        
        var body: some View {
            Group {
                if let targetViewModel = targetViewModel {
                    switch targetViewModel {
                        
                    case .peopleDetails(let viewModel):
                        PeopleDetailsView(viewModel: viewModel)
                    }
                }
            }
            .id(targetViewModel)
        }
    }
}
