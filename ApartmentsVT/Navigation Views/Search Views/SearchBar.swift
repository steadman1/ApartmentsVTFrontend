//
//  SearchBar.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI

struct SearchBar: View {
    @FocusState var textFieldFocus: Bool
    
    @State var searchQuery: String = ""
    @State var textFieldFocusAnimator = false
    
    let isEditing: Bool
    
    var body: some View {
        VStack {
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                textFieldFocus = !isEditing
            }
        }.onChange(of: textFieldFocus) { _, newValue in
            withAnimation(.navigationItemBounce) { textFieldFocusAnimator = newValue }
        }
    }
}
