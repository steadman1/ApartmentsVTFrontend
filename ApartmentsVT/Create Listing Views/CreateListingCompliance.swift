//
//  CreateListingCompliance.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct CreateListingCompliance: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @Binding var selection: Int
    @Binding var listing: Listing
    
    @State private var adaAccessible: Bool = false
    @State private var allowsPets: Bool = false
    @State private var petsPresent: String = ""
    @State private var allowsSmoking: Bool = false
    @State private var parkingAvailable: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            // ADA Compliance toggle
            Toggle(isOn: $adaAccessible) {
                Text("ADA Compliant?")
                    .font(.title3)
                    .foregroundStyle(Color.primaryText)
            }
            .padding()
            .background(Color.middleground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, Screen.padding)
            
            // Pets allowed toggle and pet type input
            Toggle(isOn: $allowsPets) {
                Text("Are pets allowed?")
                    .font(.title3)
                    .foregroundStyle(Color.primaryText)
            }
            .padding()
            .background(Color.middleground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, Screen.padding)
            
            // If pets are allowed, show the text field for pet types
            if allowsPets {
                TextField("What kind of pets?", text: $petsPresent)
                    .font(.title2)
                    .padding()
                    .background(Color.middleground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, Screen.padding)
            }
            
            // Smoking allowed toggle
            Toggle(isOn: $allowsSmoking) {
                Text("Is smoking allowed?")
                    .font(.title3)
                    .foregroundStyle(Color.primaryText)
            }
            .padding()
            .background(Color.middleground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, Screen.padding)
            
            // Parking available toggle
            Toggle(isOn: $parkingAvailable) {
                Text("Is parking available?")
                    .font(.title3)
                    .foregroundStyle(Color.primaryText)
            }
            .padding()
            .background(Color.middleground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, Screen.padding)
            
            Spacer()
            // Save button
            Button(action: {
                // Assign entered values to the listing object
                listing.adaAccessible = adaAccessible
                listing.petsAllowed = allowsPets
                listing.presentPetTypes = allowsPets ? petsPresent.components(separatedBy: ", ") : []
                listing.smokingAllowed = allowsSmoking
                listing.parkingAvailable = parkingAvailable
                
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
        .navigationTitle("Compliance")
        .padding()
    }
}

