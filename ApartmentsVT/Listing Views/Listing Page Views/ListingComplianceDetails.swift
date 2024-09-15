//
//  ListingComplianceDetails.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI

struct ListingComplianceDetails: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        VStack(spacing: Screen.halfPadding) {
            HStack {
                ListingListItem(systemName: "smoke.fill", value: listing.smokingAllowed ? "Yes" : "No", description: "Smoking Allowed", split: true)
                Spacer()
                ListingListItem(systemName: "pawprint.fill", value: listing.petsAllowed ? "Yes" : "No", description: "Furniture Included", split: true)
                Spacer()
                ListingListItem(systemName: "car.fill", value: !listing.parkingAvailable ? "Yes" : "No", description: "Utilities Included", split: true)
                Spacer()
                ListingListItem(systemName: "staroflife.fill", value: !listing.adaAccessible ? "Yes" : "No", description: "Utilities Included", split: true)
            }.padding(Screen.padding)
        }.frame(maxWidth: .infinity)
            .padding(.vertical, Screen.halfPadding)
            .background(Color.middleground)
            .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}
