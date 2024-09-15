//
//  ListingGetToKnowApartment.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI

struct ListingGetToKnowApartment: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        VStack(alignment: .leading, spacing: Screen.halfPadding) {
            Text("Get to know the \(listing.propertyType)")
                .font(.cardTitle)
                .foregroundStyle(Color.primaryText)
            Text(listing.summary)
                .font(.detail)
                .foregroundStyle(Color.primaryText)
        }.padding(Screen.padding)
            .frame(width: screen.width)
            .background(Color.middleground)
            .cornerRadius(24, corners: .allCorners)
            
    }
}
