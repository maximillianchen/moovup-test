//
//  PeopleDetailsView.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PeopleDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PeopleDetailsViewModel
    
    var body: some View {
        
        VStack {
            GoogleMapsView(
                usersLocation: [UserLocation(name: viewModel.name, latitude: viewModel.lat, longitude: viewModel.lon)]
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(alignment: .top, spacing: 20) {
                
                if let imageUrl = viewModel.imageUrl {
                    Color.clear
                        .aspectRatio(contentMode: .fit)
                        .overlay {
                            WebImage(url: imageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 84, height: 84, alignment: .center)
                                .contentShape(RoundedRectangle(cornerRadius: 8))
                                .allowsHitTesting(false)
                                .clipped()
                        }
                        .clipShape(Circle())
                        .frame(maxHeight: 60)
                }
                
                VStack(alignment: .center, spacing: 4) {
                    Text(viewModel.name)
                        .font(.system(size: 18, weight: .semibold))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text(viewModel.email)
                        .font(.system(size: 18, weight: .semibold))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(vertical: 12, horizontal: 20)
            
        }
        .navigationTitle("People Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading:
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
        )
    }
}
