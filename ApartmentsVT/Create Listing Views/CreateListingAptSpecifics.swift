//
//  CreateListingAptSpecifics.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct CreateListingAptSpecifics: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @Binding var selection: Int
    @Binding var listing: Listing
    
    @State private var bedroomCountInput: String = ""
    @State private var bathroomCountInput: String = ""
    @State private var squareFootageInput: String = ""
    @State private var furnished: Bool = false
    @State private var websiteURL: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            // Bedroom count input
            TextField("Number of Bedrooms", text: $bedroomCountInput)
                .keyboardType(.numberPad)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Bathroom count input
            TextField("Number of Bathrooms", text: $bathroomCountInput)
                .keyboardType(.numberPad)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Square footage input
            TextField("Square Footage (sq ft)", text: $squareFootageInput)
                .keyboardType(.numberPad)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Furnished toggle
            Toggle(isOn: $furnished) {
                Text("Is the apartment furnished?")
                    .font(.title3)
                    .foregroundStyle(Color.primaryText)
            }
            .padding(.horizontal, Screen.padding)
            .padding(.vertical, 8)
            .background(Color.middleground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, Screen.padding)
            
            // URL to official website input
            TextField("Official Website (URL)", text: $websiteURL)
                .keyboardType(.URL)
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            Spacer()
            // Save button
            Button(action: {
                // Assign entered values to the listing object
                if let bedroomCount = Int(bedroomCountInput) {
                    listing.bedroomCount = bedroomCount
                }
                if let bathroomCount = Int(bathroomCountInput) {
                    listing.bathroomCount = bathroomCount
                }
                if let squareFootage = Int(squareFootageInput) {
                    listing.squareFootage = squareFootage
                }
                listing.furnished = furnished
                listing.urlToListing = websiteURL
                
                selection += 1
                // Proceed to next section or save the listing data
            }) {
                Text("Continue")
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, Screen.padding)
            }
        }
        .navigationTitle("Apartment Specifics")
        .padding()
    }
}

