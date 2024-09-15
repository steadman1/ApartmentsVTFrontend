//
//  SearchPage.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct SearchView: View {
    @EnvironmentObject var screen: Screen
    @EnvironmentObject var defaults: ObservableDefaults
    
    @State private var searchQuery = ""
    @State private var listings: [Listing] = Listing.sampleListings
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                ScrollView {
                    VStack {
                        Spacer().frame(height: Screen.padding * (searchQuery.isEmpty ? 1 : 4))
                        if (!listings.isEmpty) {
                            ForEach(listings, id: \.id) { listing in
                                ListingInline(listing)
                            }
                            
                            Spacer().frame(height: Screen.padding)
                            
                            Text("Found \(listings.count) listings matching query.")
                                .font(.subheading)
                                .foregroundStyle(Color.secondaryText)
                        } else {
                            Text("No Listings Found.")
                                .font(.heading)
                                .foregroundStyle(Color.primaryText)
                        }
                    }.frame(maxWidth: .infinity)
                }
                Spacer().frame(height: screen.safeAreaInsets.bottom + Screen.padding * 3)
            }.padding(.top, 64)
            SearchBar(listings: $listings, searchQuery: $searchQuery, isEditing: true)
        }.frame(maxHeight: .infinity)
            .background(Color.background)
            .ignoresSafeArea(.all, edges: .bottom)
    }
}

