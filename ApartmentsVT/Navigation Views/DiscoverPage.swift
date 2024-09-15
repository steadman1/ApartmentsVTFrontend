//
//  Discover.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct DiscoverPage: View {
    @EnvironmentObject var screen: Screen
    
    let discoverTopBarHeight: CGFloat = 160
    
    var body: some View {
        let topInset: CGFloat = screen.safeAreaInsets.top + Screen.padding * 3
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    RecommendedListings(type: .nearCampus)
                    RecommendedListings(type: .nearGroceries)
                }.padding(.top, discoverTopBarHeight + topInset - Screen.padding * 2)
                    .frame(maxWidth: .infinity)
            }
            DiscoverTopBar(topInset: topInset, height: discoverTopBarHeight)
        }.frame(height: screen.height)
            .background(Color.background)
            .ignoresSafeArea()
    }
}

