//
//  PeopleItemView.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PeopleItemView: View {
    
    let user: User
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top, spacing: 20) {
                
                if let imageUrl = URL(string: user.picture) {
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
                
                VStack(alignment: .center, spacing: 0) {
                    Text("\(user.name.last) \(user.name.first)")
                        .font(.system(size: 18, weight: .semibold))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .padding(vertical: 12, horizontal: 20)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.secondary, lineWidth: 0.5)
            )
        }
        .contentShape(Rectangle())
        .padding(vertical: 10, horizontal: 10)
        
    }
}
