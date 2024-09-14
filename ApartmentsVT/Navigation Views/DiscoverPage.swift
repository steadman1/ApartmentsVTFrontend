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
    
    let discoverTopBarHeight: CGFloat = 260
    
    var body: some View {
        let topInset: CGFloat = screen.safeAreaInsets.top + Screen.padding * 3
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    ForEach(0..<100) { index in
                        Text("hi \(index)")
                    }
                }.padding(.top, discoverTopBarHeight + topInset - Screen.padding * 2)
                    .frame(maxWidth: .infinity)
            }
            DiscoverTopBar(topInset: topInset, height: discoverTopBarHeight)
        }.frame(height: screen.height)
            .ignoresSafeArea()
    }
}

