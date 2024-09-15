//
//  ListingMaps.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI
import CoreLocation
import MapKit

struct ListingMaps: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ListingMapView(listing: listing)
                .frame(width: screen.width, height: screen.width)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.darkGradient, location: 0), // Bottom
                            .init(color: Color.black.opacity(0.0), location: 1) // Middle
                        ]),
                        startPoint: .bottom,
                        endPoint: .center
                    )
                )

            VStack(spacing: 2) {
                HStack {
                    ZStack {
                        Text("Proximity to Campus")
                            .font(.heading)
                            .foregroundStyle(Color.glassText)
                    }.padding(.vertical, Screen.halfPadding)
                        .padding(.horizontal, Screen.padding)
                        .glassEffect()
                    
                    Spacer()
                    
                    ZStack {
                        HStack {
                            Text("Maps")
                                .font(.heading)
                                .foregroundStyle(Color.glassText)
                            Image(systemName: "arrow.up.forward")
                                .font(.subheadingIcon)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.glassText)
                        }
                    }.padding(.vertical, Screen.halfPadding)
                        .padding(.horizontal, Screen.padding)
                        .glassEffect()
                }.padding(.horizontal, Screen.halfPadding)
                HStack {
                    GlassListingListItem(systemName: "figure.walk", value: "\(listing.walkTime.description)m", description: "Walk")
                    Spacer()
                    GlassListingListItem(systemName: "bicycle", value: "\(listing.bikeTime.description)m", description: "Bike")
                    Spacer()
                    GlassListingListItem(systemName: "bus.fill", value: "\(listing.busRoutesCount.description)", description: "Bus Routes")
                    Spacer()
                    GlassListingListItem(systemName: "car.fill", value: "\(listing.driveTime.description)m", description: "Drive")
                }.padding(Screen.padding)
                    .glassEffect(cornerRadius: 20)
                    .padding(Screen.halfPadding)
            }
        }
        .frame(width: screen.width, height: screen.width) // Fixed size for the card
            .cornerRadius(24, corners: .allCorners)
    }
}
