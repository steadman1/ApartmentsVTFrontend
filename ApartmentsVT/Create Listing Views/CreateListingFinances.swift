//
//  CreateListing Finances.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct CreateListingAptFinances: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @Binding var selection: Int
    @Binding var listing: Listing
    
    @State private var depositInput: String = ""
    @State private var includedUtilitiesInput: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            // Security deposit input
            TextField("Security Deposit Amount", text: $depositInput)
                .keyboardType(.numberPad)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Included utilities input
            TextField("Included Utilities (comma-separated)", text: $includedUtilitiesInput)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            Spacer()
            // Save button
            Button(action: {
                // Assign entered values to the listing object
                if let depositAmount = Int(depositInput) {
                    listing.depositRequired = depositAmount
                }
                listing.utilitiesIncluded = includedUtilitiesInput.components(separatedBy: ", ")
                
                selection += 1
                // Proceed to next section or save the listing data
            }) {
                Text("Save and Finish")
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, Screen.padding)
            }
        }
        .navigationTitle("Apartment Finances")
        .padding()
    }
}

