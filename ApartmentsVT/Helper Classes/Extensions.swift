//
//  Extensions.swift
//  Lotus
//
//  Created by Spencer Steadman on 3/28/24.
//

import SwiftUI
import SteadmanUI

extension Font {
    static var navigationBar: Font {
        Font.custom("Inter", size: 9)
            .weight(.medium)
    }
    static var navigationBarIcon: Font {
        Font.system(size: 20)
            .weight(.bold)
    }
    static var title: Font {
        Font.custom("Inter", size: 32)
            .weight(.semibold)
    }
    static var subtitle: Font {
        Font.custom("Manrope", size: 16)
            .weight(.medium)
    }
    static var heading: Font {
        Font.custom("Inter", size: 16)
            .weight(.semibold)
    }
    static var subheading: Font {
        Font.custom("Inter", size: 10)
            .weight(.medium)
    }
    static var detail: Font {
        Font.custom("Inter", size: 12)
            .weight(.bold)
    }
    static var headingIcon: Font {
        Font.system(size: 20)
            .weight(.bold)
    }
    static var subheadingIcon: Font {
        Font.system(size: 12)
            .weight(.bold)
    }
    static var detailIcon: Font {
        Font.system(size: 16)
            .weight(.bold)
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}

extension Date {
    func timeAgo() -> String {
        let now = Date()
        let difference = Calendar.current.dateComponents([.minute, .hour, .day, .weekOfYear, .month, .year], from: self, to: now)
        
        if let year = difference.year, year > 0 {
            return "\(year)y ago"
        } else if let month = difference.month, month > 0 {
            return "\(month)mo ago"
        } else if let week = difference.weekOfYear, week > 0 {
            return "\(week)w ago"
        } else if let day = difference.day, day > 0 {
            return "\(day)d ago"
        } else if let hour = difference.hour, hour > 0 {
            return "\(hour)hr ago"
        } else if let minute = difference.minute, minute > 8 {
            return "\(minute)m ago"
        } else {
            return "Now"
        }
    }
    
    func within8Minutes() -> Bool {
        let now = Date()
        let difference = Calendar.current.dateComponents([.minute, .hour, .day, .weekOfYear, .month, .year], from: self, to: now)
        
        if let year = difference.year, year < 0,
           let month = difference.month, month < 0,
           let week = difference.weekOfYear, week < 0,
           let day = difference.day, day < 0,
           let hour = difference.hour, hour < 0,
           let minute = difference.minute, minute <= 8 {
            return true
        }
        return false
    }
}

extension URL {
    func convertToHTTPS() -> URL {
        // check if scheme is already https
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true), components.scheme != "https" else {
            return self
        }
        
        // Change the scheme to https
        components.scheme = "https"
        
        // Return the new URL, or nil if there was an issue constructing it
        return components.url!
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusModifier: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.modifier(CornerRadiusModifier(radius: radius, corners: corners))
    }
}
