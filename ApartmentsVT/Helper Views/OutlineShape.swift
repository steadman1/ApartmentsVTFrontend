//
//  OutlineShape.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI

struct OutlineShape: ViewModifier {
    var cornerRadius: CGFloat = 100 // Default corner radius
    var strokeColor: Color = Color.primaryText // Default stroke color
    var lineWidth: CGFloat = 2 // Default border width
    
    func body(content: Content) -> some View {
        content
            .background(.middleground) // Glass effect background
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // Clip shape with rounded corners
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth) // Apply border
            )
    }
}

extension View {
    // Convenience function to apply GlassShape
    func outlineEffect(cornerRadius: CGFloat = 100, strokeColor: Color = .primaryText, lineWidth: CGFloat = 2) -> some View {
        self.modifier(OutlineShape(cornerRadius: cornerRadius, strokeColor: strokeColor, lineWidth: lineWidth))
    }
}


