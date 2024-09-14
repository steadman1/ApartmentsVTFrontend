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
    var body: some View {
        VStack {
            DiscoverTopBar()
            Text("hi")
        }.frame(maxWidth: .infinity)
            .frame(height: screen.height)
    }
}

