//
//  UserProfileContainer.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct UserProfileContainer: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let user: User
    
    let size: CGFloat = 48
    
    var body: some View {
        VStack {
            // Check if the user has a valid profile picture URL
            if let profilePictureURL = user.profilePictureURL {
                // Use AsyncImage to load the image from the URL
                AsyncImage(url: profilePictureURL) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder while the image is loading
                        ProgressView()
                    case .success(let image):
                        // Successfully loaded image
                        ZStack(alignment: .bottomTrailing) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size, height: size)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(Color.glassText, lineWidth: 2)
                                }
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.active)
                                .overlay {
                                    Circle().stroke(Color.glassText, lineWidth: 2)
                                }
                        }
                    case .failure:
                        // Fallback image if loading fails
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: size, height: size)
                            .foregroundStyle(Color.glassText)
                    @unknown default:
                        // Default case for future SwiftUI updates
                        EmptyView()
                    }
                }
            } else {
                // Fallback image if user does not have a profile picture URL
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: size, height: size)
            }
        }
    }
}



