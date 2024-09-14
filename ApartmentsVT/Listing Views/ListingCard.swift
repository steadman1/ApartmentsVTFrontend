//
//  ListingCard.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct ComplianceType {
    let title: String
    private let compliant: String
    private let notCompliant: String
    
    // Static instances for each compliance type
    static let ada = ComplianceType(
        title: "ADA Compliance",
        compliant: "This property is accessible for individuals with disabilities.",
        notCompliant: "This property is not accessible for individuals with disabilities."
    )
    
    static let pets = ComplianceType(
        title: "Pets Allowed",
        compliant: "This property allows pets.",
        notCompliant: "This property does not allow pets."
    )
    
    static let parking = ComplianceType(
        title: "Parking Available",
        compliant: "This property has parking available.",
        notCompliant: "This property does not have parking available."
    )
    
    static let smoking = ComplianceType(
        title: "Smoking Allowed",
        compliant: "This property allows smoking.",
        notCompliant: "This property does not allow smoking."
    )
    
    // Function to return the appropriate message based on compliance
    func getInfo(_ isCompliant: Bool) -> String {
        return isCompliant ? compliant : notCompliant
    }
    
    static let allComplianceTypes = [
        ada, pets, parking, smoking
    ]
}


struct ComplianceButton: View {
    
    let complianceType: ComplianceType
    let listing: Listing
    
    var value = false
    
    var body: some View {
        Button {
            
            print("bookmark")
        } label: {
            ZStack {
                Image(.bookmark)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.glassText)
                
            }.frame(width: 40, height: 40)
                .glassEffect()
        }
    }
}

struct ListingCard: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    init(_ listing: Listing) {
        self.listing = listing
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                .frame(width: 296, height: 348) // Ensure image takes the correct size
            } else {
                // Fallback if no image is available
                Color.gray.frame(width: 296, height: 348)
            }
            
            
            Button {
                // TODO toggle bookmark
                print("bookmark")
            } label: {
                ZStack {
                    Image(.bookmark)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.glassText)
                    
                }.frame(width: 48, height: 48)
                    .glassEffect()
                    .padding(Screen.padding)
            }
            
            VStack {
                HStack(spacing: Screen.halfPadding) {
                    ForEach(ComplianceType.allComplianceTypes, id: \.title) { compliance in
                        
                        ComplianceButton(complianceType: compliance, listing: listing)
                    }
                }
                Spacer()
            }.frame(maxHeight: .infinity)
                .padding(Screen.padding)

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
            }.padding(Screen.padding)
                .padding(.trailing, Screen.padding + 48)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
        }
        .frame(width: 296, height: 348) // Fixed size for the card
        .cornerRadius(40) // Rounded corners for the card
    }
}

#Preview {
    ListingCard(Listing.sampleListings[0])
}
