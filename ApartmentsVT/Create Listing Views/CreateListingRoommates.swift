//
//  CreateListingRoommates.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct CreateListingRoommates: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @Binding var selection: Int
    @Binding var listing: Listing
    
    @State private var roommateCountInput: String = ""
    @State private var roommateIntro: String = ""
    @State private var gendersInApt: String = ""
    @State private var languagesSpoken: String = ""
    @State private var nationalities: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            // Roommate introduction
            TextEditor(text: $roommateIntro)
                .frame(height: 120)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primaryText.opacity(0.2), lineWidth: 1)
                )
                .foregroundStyle(Color.primaryText)
                .placeholder(when: roommateIntro.isEmpty) {
                    Text("Introduce the current roommates").foregroundColor(.gray)
                }
            
            // Roommate count input
            TextField("Number of Roommates", text: $roommateCountInput)
                .keyboardType(.numberPad)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Genders in apartment (optional)
            TextField("Genders in Apartment (optional)", text: $gendersInApt)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Languages spoken (optional)
            TextField("Languages Spoken (optional)", text: $languagesSpoken)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Nationalities (optional)
            TextField("Nationalities (optional)", text: $nationalities)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            Spacer()
            // Save button
            Button(action: {
                // Assign entered values to the listing object
                if let roommateCount = Int(roommateCountInput) {
                    listing.roommateCount = roommateCount
                }
                listing.roommateBio = roommateIntro
                listing.gender = gendersInApt.isEmpty ? nil : gendersInApt.components(separatedBy: ", ")
                listing.nationality = nationalities.isEmpty ? nil : nationalities.components(separatedBy: ", ")
                listing.languages = languagesSpoken.split(separator: " ") as? [String]
                
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
        .navigationTitle("Roommates")
        .padding()
    }
}

