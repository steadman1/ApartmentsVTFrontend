//
//  ListingApartmentDetails.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI

struct ListingApartmentDetails: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        VStack(spacing: Screen.halfPadding) {
            HStack {
                ListingListItem(systemName: "", value: "$\(listing.depositRequired.description)", description: "Deposit Required", split: true)
                Spacer()
                ListingListItem(systemName: "sofa.fill", value: listing.furnished ? "Yes" : "No", description: "Furniture Included", split: true)
                Spacer()
                ListingListItem(systemName: "bolt.fill", value: !listing.utilitiesIncluded.isEmpty ? "Yes" : "No", description: "Utilities Included", split: true)
            }.padding(Screen.padding)
        }.frame(maxWidth: .infinity)
            .padding(.vertical, Screen.halfPadding)
            .background(Color.middleground)
            .cornerRadius(24, corners: .allCorners)
    }
}
