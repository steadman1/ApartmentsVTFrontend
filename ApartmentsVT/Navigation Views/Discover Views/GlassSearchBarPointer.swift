//
//  GlassSearchBarPointer.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct GlassSearchBarPointer: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(.magnifyingglass)
                    .font(.icon)
                    .foregroundStyle(Color.glassText)
                VStack(alignment: .leading) {
                    Text("Smart Search")
                        .font(.heading)
                        .foregroundStyle(Color.glassText)
                    Text("Get AI Curated listings. Just for you.")
                        .font(.subheading)
                        .foregroundStyle(Color.glassText)
                }
                Spacer()
            }.padding(.horizontal, Screen.padding)
        }.frame(height: 64)
            .frame(maxWidth: .infinity)
            .glassEffect(cornerRadius: 100)
    }
}
