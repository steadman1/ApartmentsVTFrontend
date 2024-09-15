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
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    // TODO add pagination
                    print("test")
                } label: {
                    ZStack {
                        Image(systemName: "chevron.left")
                            .font(.subheadingIcon)
                    }.frame(width: 40, height: 40)
                        .outlineEffect()
                }

                Text("Details")
                    .font(.title)
                    .foregroundStyle(.primaryText)
                
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

            }
        }
    }
}

#Preview {
    ListingPage(listing: Listing.sampleListings[0])
}
