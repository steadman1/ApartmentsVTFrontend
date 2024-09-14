//
//  GlassShape.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI

struct GlassShape: ViewModifier {
    var cornerRadius: CGFloat = 100 // Default corner radius
    var strokeColor: Color = Color.glassBorder // Default stroke color
    var lineWidth: CGFloat = 2 // Default border width
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial) // Glass effect background
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // Clip shape with rounded corners
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: lineWidth) // Apply border
            )
    }
}

extension View {
    // Convenience function to apply GlassShape
    func glassEffect(cornerRadius: CGFloat = 100, strokeColor: Color = .glassBorder, lineWidth: CGFloat = 1) -> some View {
        self.modifier(GlassShape(cornerRadius: cornerRadius, strokeColor: strokeColor, lineWidth: lineWidth))
    }
}

