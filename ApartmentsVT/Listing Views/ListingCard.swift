//
//  ListingCard.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct ListingCard: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    init(_ listing: Listing) {
        self.listing = listing
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
                            .frame(width: 296, height: 348)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.black.opacity(0.6), location: 0), // Bottom
                                        .init(color: Color.black.opacity(0.0), location: 0.5) // Middle
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
                .frame(width: 296, height: 348) // Ensure image takes the correct size
            } else {
                // Fallback if no image is available
                Color.gray.frame(width: 296, height: 348)
            }
            
            ZStack {
                Image(systemName: "bookmark")
                    .font(.headingIcon)
                    .foregroundStyle(Color.glassText)
                
            }.frame(width: 48, height: 48)
                .glassEffect()

            // Text content on top of the image and gradient
            VStack(alignment: .leading, spacing: 4) {
                Text("\(listing.bedroomCount) bed, \(listing.bathroomCount) bath at \(listing.apartmentComplexName)")
                    .font(.cardTitle)
                    .foregroundStyle(.glassText)
                Text("$\(listing.price)")
                    .font(.heading)
                    .foregroundStyle(.glassText)
                + Text("/\(listing.period)")
                    .font(.subheading)
                    .foregroundStyle(.glassSecondaryText)
            }
            .padding() // Add padding for text content
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
        }
        .frame(width: 296, height: 348) // Fixed size for the card
        .cornerRadius(16) // Rounded corners for the card
        .shadow(radius: 4) // Optional: add shadow for a card effect
    }
}

#Preview {
    ListingCard(Listing.sampleListings[0])
}
