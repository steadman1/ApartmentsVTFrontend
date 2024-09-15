//
//  DiscoverTopBar.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct DiscoverTopBar: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @State var isCreatingListing = false
    
    let topInset: CGFloat
    let height: CGFloat
    
    let campusName = "Virginia Tech"
    let campusCity = "Blacksburg"
    let campusState = "VA"
    
    var body: some View {
        ZStack {
            Image(.burrusHall)
                .resizable()
                .frame(height: height + topInset)
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Color.black.opacity(0.45)
                )
                .clipped()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(.arrow)
                        .font(.icon)
                        .foregroundStyle(Color.glassText)
                    VStack(alignment: .leading) {
                        Text(campusName)
                            .font(.heading)
                            .foregroundStyle(Color.glassText)
                        Text("\(campusCity), \(campusState)")
                            .font(.subheading)
                            .foregroundStyle(Color.glassText)
                    }
                    
                    Spacer()
                    
                    Button {
                        isCreatingListing.toggle()
                    } label: {
                        UserProfileContainer(user: User.sampleUser)
                    }

                }
                
//                Spacer()
//                
//                VStack(alignment: .leading) {
//                    Text("Discover Listings")
//                        .font(.title)
//                        .foregroundStyle(Color.glassText)
//                    Text("Find your perfect property.")
//                        .font(.subtitle)
//                        .foregroundStyle(Color.glassText)
//                }
                
                Spacer()
                
                GlassSearchBarPointer()
            }.frame(maxWidth: .infinity)
                .padding(Screen.padding)
                .padding(.top, topInset)
        }.cornerRadius(40, corners: [.bottomLeft, .bottomRight])
            .frame(height: height)
            .fullScreenCover(isPresented: $isCreatingListing) {
                CreateListing().environmentObject(screen)
            }
    }
}
