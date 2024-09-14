//
//  RecommendedListings.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct RecommendedListingType {
    let title: String
    let info: String
    
    static let nearCampus: RecommendedListingType = RecommendedListingType(
        title: "Near Campus",
        info: "Properties within 5 miles of your campus."
    )
    
    static let nearGroceries: RecommendedListingType = RecommendedListingType(
        title: "Near Groceries",
        info: "Properties within 5 miles of a at least one grocery store."
    )
}

struct RecommendedListings: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @State var listings: [Listing] = Listing.sampleListings
    
    let type: RecommendedListingType
    
    var body: some View {
        VStack {
            ForEach(listings, id: \.id) { listing in
                ListingCard(listing)
            }
        }
    }
}
