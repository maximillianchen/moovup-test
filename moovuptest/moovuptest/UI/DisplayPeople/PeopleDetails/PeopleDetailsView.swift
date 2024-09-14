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
//        VStack {
//            Text("user: \(viewModel.user?.name.last) \(viewModel.user?.name.first)")
//        }
        
        VStack {
            GoogleMapsView()
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("People Details")
    }
}
