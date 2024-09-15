//
//  ListingInline.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct ListingInline: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    init(_ listing: Listing) {
        self.listing = listing
    }
    
    let width: CGFloat = 140
    let height: CGFloat = 120
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    // Background AsyncImage with Gradient
                    if let imageURL = listing.imagesURLs.first {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder while image loads
                                Color.gray
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: width, height: height)
                                    .overlay(
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                .init(color: Color.darkGradient, location: 0), // Bottom
                                                .init(color: Color.black.opacity(0.0), location: 0.75) // Middle
                                            ]),
                                            startPoint: .bottom,
                                            endPoint: .center
                                        )
                                    )
                                    .clipped()
                            case .failure:
                                // Fallback for loading failure
                                Color.gray
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: width, height: height) // Ensure image takes the correct size
                    } else {
                        // Fallback if no image is available
                        Color.gray.frame(width: width, height: height)
                    }
                }.cornerRadius(16, corners: .allCorners)
                
                
                Button {
                    // TODO toggle bookmark
                    print("bookmark")
                } label: {
                    ZStack {
                        Image(.bookmark)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.glassText)
                        
                    }.frame(width: 40, height: 40)
                        .glassEffect()
                        .padding(Screen.halfPadding)
                }
            }.padding(.leading, Screen.halfPadding)
            
            VStack(alignment: .leading, spacing: 0) {
                // Text content on top of the image and gradient
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(listing.bedroomCount) bed, \(listing.bathroomCount) bath at \(listing.apartmentComplexName)")
                        .font(.cardTitle)
                        .foregroundStyle(.primaryText)
                    Text("$\(listing.price)")
                        .font(.heading)
                        .foregroundStyle(.primaryText)
                    + Text("/\(listing.period)")
                        .font(.subheading)
                        .foregroundStyle(.secondaryText)
                }
                
                Spacer()
                
                HStack(spacing: Screen.halfPadding) {
                    ForEach(ComplianceType.allComplianceTypes, id: \.title) { compliance in
                        ComplianceButton(
                            uiDesignType: .outline,
                            complianceType: compliance,
                            listing: listing
                        )
                    }
                }
            }.padding(Screen.halfPadding)
            Spacer()
        }.frame(width: screen.width - Screen.padding * 2)
            .frame(height: height + Screen.padding)
            .background(.middleground)
            .cornerRadius(24, corners: .allCorners)
        
    }
}
    
#Preview {
    ListingInline(Listing.sampleListings[0])
}
