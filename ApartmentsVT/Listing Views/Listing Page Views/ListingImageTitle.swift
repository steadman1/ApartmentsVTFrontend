//
//  ListingImageTitle.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI
import MapKit
import CoreLocation

struct ListingImageTitle: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @State private var address: String = "Loading address..."
    
    let listing: Listing
    
    let height: CGFloat = 300
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Background AsyncImage with Gradient
            if let imageURL = listing.imagesURLs.first {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder while image loads
                        Color.gray
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
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
                            .clipped()
                    case .failure:
                        // Fallback for loading failure
                        Image(.burrusHall)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
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
                            .clipped()
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: screen.width, height: screen.width) // Ensure image takes the correct size
            } else {
                // Fallback if no image is available
                Image(.burrusHall)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
                    .clipped()
            }

            // Text content on top of the image and gradient
            VStack(alignment: .leading, spacing: 4) {
                Text("\(listing.bedroomCount) bed, \(listing.bathroomCount) bath at \(listing.apartmentComplexName)")
                    .font(.title)
                    .foregroundStyle(.glassText)
                Text("$\(listing.price)")
                    .font(.heading)
                    .foregroundStyle(.glassText)
                + Text("/\(listing.period)")
                    .font(.subheading)
                    .foregroundStyle(.glassSecondaryText)
                Text(address)
                    .font(.detail)
                    .foregroundStyle(.glassText)
            }.padding(Screen.padding)
                .padding(.trailing, Screen.padding + 48)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
        }
        .frame(width: screen.width, height: screen.width) // Fixed size for the card
            .cornerRadius(24, corners: .allCorners)
            .onAppear {
                convertCoordinatesToAddress(
                    latitude: CLLocationDegrees(listing.latitude),
                    longitude: CLLocationDegrees(listing.longitude)
                ) { retrievedAddress in
                    if let retrievedAddress = retrievedAddress {
                        address = retrievedAddress
                    } else {
                        address = "No address found."
                    }
                }
            }
    }

    func convertCoordinatesToAddress(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error occurred during reverse geocoding: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                var addressString = ""
                
                // Optional: Construct the address string using available placemark properties
                if let street = placemark.thoroughfare {
                    addressString += street + ", "
                }
                if let city = placemark.locality {
                    addressString += city + ", "
                }
                if let state = placemark.administrativeArea {
                    addressString += state + " "
                }
                if let postalCode = placemark.postalCode {
                    addressString += postalCode + " "
                }
                if let country = placemark.country {
                    addressString += country
                }
                
                // Return the constructed address string
                completion(addressString.isEmpty ? nil : addressString)
            } else {
                // No placemarks found
                completion(nil)
            }
        }
    }

}
