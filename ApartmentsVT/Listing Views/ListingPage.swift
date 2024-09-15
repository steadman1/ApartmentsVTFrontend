//
//  ListingPage.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct ListingPage: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        ScrollView {
            VStack(spacing: 2) {
                HStack {
                    Button {
                        // TODO add pagination
                        dismiss()
                    } label: {
                        ZStack {
                            Image(systemName: "chevron.left")
                                .font(.subheadingIcon)
                                .foregroundStyle(Color.primaryText)
                        }.frame(width: 40, height: 40)
                            .outlineEffect()
                    }
                    
                    Spacer()

                    Text("Details")
                        .font(.heading)
                        .foregroundStyle(.primaryText)
                    
                    Spacer()
                    
                    Button {
                        // TODO add bookmarking
                        print("test")
                    } label: {
                        ZStack {
                            Image(.bookmark)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.primaryText)
                        }.frame(width: 40, height: 40)
                            .outlineEffect()
                    }
                }.padding(Screen.padding)
                    .frame(maxWidth: .infinity)
                    .background(Color.middleground)
                    .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                
                ListingImageTitle(listing: listing).environmentObject(screen)
                ListingBasicDetails(listing: listing).environmentObject(screen)
                ListingGetToKnowApartment(listing: listing).environmentObject(screen)
                ListingApartmentDetails(listing: listing).environmentObject(screen)
                ListingMaps(listing: listing).environmentObject(screen)
                ListingRoommateDetails(listing: listing).environmentObject(screen)
                ListingComplianceDetails(listing: listing).environmentObject(screen)
                
//                ZStack {
//                    Text("Contact Roommates")
//                        .font(.heading)
//                        .foregroundStyle(Color.glassText)
//                }.frame(width: screen.width - Screen.padding * 4, height: 60)
//                    .padding(.horizontal, Screen.padding)
//                    .background(Color.foreground)

                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ListingPage(listing: Listing.sampleListings[0])
}
