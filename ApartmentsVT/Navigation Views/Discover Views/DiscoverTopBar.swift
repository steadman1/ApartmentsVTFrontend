//
//  DiscoverTopBar.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct DiscoverTopBar: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let campusName = "Virginia Tech"
    let campusCity = "Blacksburg"
    let campusState = "VA"
    
    var body: some View {
        VStack {
            HStack {
                Image(.arrow)
                    .font(.icon)
                VStack {
                    Text(campusName)
                        .font(.heading)
                    Text("\(campusCity), \(campusState)")
                        .font(.subheading)
                }
            }
        }.cornerRadius(32, corners: [.bottomLeft, .bottomRight])
    }
}
