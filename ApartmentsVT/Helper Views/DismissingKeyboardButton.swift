//
//  DismissingKeyboardButton.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI
import Foundation
import SteadmanUI

struct DismissingKeyboardButton: View {
    @EnvironmentObject var screen: Screen
    @EnvironmentObject var defaults: ObservableDefaults
    var textFieldFocus: FocusState<Bool>.Binding
    
    var body: some View {
        Button {
            textFieldFocus.wrappedValue = false
        } label: {
            Image(systemName: "keyboard.chevron.compact.down.fill")
                .font(.miniIcon.bold())
        }.frame(height: textFieldFocus.wrappedValue ? 24 : 0)
            .opacity(textFieldFocus.wrappedValue ? 1 : 0)
            .animation(.navigationItemBounce, value: textFieldFocus.wrappedValue)
            .onChange(of: textFieldFocus.wrappedValue) { _, _ in
                Screen.impact(enabled: true)
            }
    }
}
