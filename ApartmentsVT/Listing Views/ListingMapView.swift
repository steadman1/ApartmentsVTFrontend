//
//  ListingMapView.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import MapKit
import SteadmanUI
import CoreLocation

struct ListingMapView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    @State private var region: MKCoordinateRegion
    
    // Initialize region in the init method with listing latitude and longitude
    init(listing: Listing) {
        self.listing = listing
        // Initial region for the map (centered on the listing coordinates)
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: CLLocationDegrees(listing.latitude), longitude: CLLocationDegrees(listing.longitude)),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Adjust zoom level
        ))
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $region, annotationItems: [listing]) { listing in
                // Pin annotation for the listing location
                MapAnnotation(coordinate: CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(listing.latitude),
                    longitude: CLLocationDegrees(listing.longitude)
                )) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
            }
            .frame(width: screen.width, height: screen.width)
            .overlay(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.darkGradient, location: 0), // Bottom
                        .init(color: Color.black.opacity(0.0), location: 0.75) // Middle
                    ]),
                    startPoint: .bottom,
                    endPoint: .center
                )
            )
        }
        .frame(width: screen.width, height: screen.width) // Fixed size for the card
    }
}


