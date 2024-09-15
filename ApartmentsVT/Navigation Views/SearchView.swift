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
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                ScrollView {
                    VStack {
                        Spacer().frame(height: Screen.padding)
                        ForEach(0..<100) { index in
                            Text("hi \(index)")
                        }
                    }.frame(maxWidth: .infinity)
                }
                Spacer().frame(height: screen.safeAreaInsets.bottom + Screen.padding * 3)
            }.padding(.top, 64)
            SearchBar(isEditing: true)
        }.frame(maxHeight: .infinity)
            .background(Color.background)
    }
}

