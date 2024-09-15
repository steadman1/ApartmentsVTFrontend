//
//  ListingBasicDetails.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI

struct GlassListingListItem: View {
    let systemName: String
    let value: String
    let description: String
    let color: Color?
    
    init(systemName: String, value: String, description: String, split: Bool = false, color: Color? = nil) {
        self.systemName = systemName
        self.value = value
        if (split) {
            self.description = description.split(separator: " ").joined(separator: "\n")
        } else {
            self.description = description
        }
        self.color = color
    }
    
    var body: some View {
        VStack {
            HStack {
                if (!systemName.isEmpty) {
                    Image(systemName: systemName)
                        .font(.subheadingIcon)
                        .foregroundStyle(Color.glassText)
                }
                Text(value)
                    .font(.heading)
                    .foregroundStyle(Color.glassText)
            }
            Text(description)
                .multilineTextAlignment(.center)
                .font(.subheading)
                .foregroundStyle(Color.glassText)
        }
    }
}

struct ListingListItem: View {
    let systemName: String
    let value: String
    let description: String
    
    init(systemName: String, value: String, description: String, split: Bool = false) {
        self.systemName = systemName
        self.value = value
        if (split) {
            self.description = description.split(separator: " ").joined(separator: "\n")
        } else {
            self.description = description
        }
    }
    
    var body: some View {
        VStack(spacing: Screen.halfPadding) {
            HStack {
                if (!systemName.isEmpty) {
                    Image(systemName: systemName)
                        .font(.headingIcon)
                        .foregroundStyle(Color.primaryText)
                }
                Text(value)
                    .font(.cardTitle)
                    .foregroundStyle(Color.primaryText)
            }
            Text(description)
                .multilineTextAlignment(.center)
                .font(.detail)
                .foregroundStyle(Color.secondaryText)
        }
    }
}

struct ListingBasicDetails: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        VStack(spacing: Screen.halfPadding) {
            HStack {
                ListingListItem(systemName: "bed.double.fill", value: listing.bedroomCount.description, description: "Bedrooms")
                Spacer()
                ListingListItem(systemName: "bathtub.fill", value: listing.bathroomCount.description, description: "Bathrooms")
                Spacer()
                ListingListItem(systemName: "person.3.fill", value: listing.roommateCount.description, description: "Roommates")
                Spacer()
                ListingListItem(systemName: "ruler.fill", value: listing.bedroomCount.description, description: "Square Feet")
            }.padding(Screen.padding)
        }.frame(maxWidth: .infinity)
            .padding(.vertical, Screen.halfPadding)
            .background(Color.middleground)
            .cornerRadius(24, corners: .allCorners)
    }
}
