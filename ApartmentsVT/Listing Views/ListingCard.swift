//
//  ListingCard.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct ComplianceType {
    enum Compliance {
        case ada, pets, smoking, parking
    }
    
    let enumeration: Compliance
    let title: String
    let icon: String
    private let compliant: String
    private let notCompliant: String
    
    // Static instances for each compliance type
    static let ada = ComplianceType(
        enumeration: .ada,
        title: "ADA Compliance",
        icon: "staroflife.fill",
        compliant: "This property is accessible for individuals with disabilities.",
        notCompliant: "This property is not accessible for individuals with disabilities."
    )
    
    static let pets = ComplianceType(
        enumeration: .pets,
        title: "Pets Allowed",
        icon: "pawprint.fill",
        compliant: "This property allows pets.",
        notCompliant: "This property does not allow pets."
    )
    
    static let parking = ComplianceType(
        enumeration: .parking,
        title: "Parking Available",
        icon: "car.fill",
        compliant: "This property has parking available.",
        notCompliant: "This property does not have parking available."
    )
    
    static let smoking = ComplianceType(
        enumeration: .smoking,
        title: "Smoking Allowed",
        icon: "smoke.fill",
        compliant: "This property allows smoking.",
        notCompliant: "This property does not allow smoking."
    )
    
    // Function to return the appropriate message based on compliance
    func getInfo(_ isCompliant: Bool) -> String {
        return isCompliant ? compliant : notCompliant
    }
    
    static let allComplianceTypes = [
        ada, pets, parking, smoking
    ]
}

enum UIDesignType {
    case glass, outline
}

struct ComplianceButton: View {
    @State private var showAlert = false // State to control the alert
    let uiDesignType: UIDesignType
    let complianceType: ComplianceType
    let listing: Listing
    
    var body: some View {
        var value = false
        switch complianceType.enumeration {
        case .ada:
            value = listing.adaAccessible
        case .pets:
            value = listing.petsAllowed
        case .smoking:
            value = listing.smokingAllowed
        case .parking:
            value = listing.parkingAvailable
        }
        
        return Button {
            showAlert = true // Trigger the alert
        } label: {
            ZStack(alignment: .bottomTrailing) {
                switch uiDesignType {
                case .glass:
                    ZStack {
                        Image(systemName: complianceType.icon)
                            .font(.subheadingIcon)
                            .foregroundStyle(Color.glassText)
                        
                    }.frame(width: 40, height: 40)
                        .glassEffect()
                case .outline:
                    ZStack {
                        Image(systemName: complianceType.icon)
                            .font(.detailIcon)
                            .foregroundStyle(Color.primaryText)
                        
                    }.frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.primaryText, lineWidth: 2)
                        )
                }
                Circle()
                    .frame(width: uiDesignType == .outline ? 10 : 14, height: uiDesignType == .outline ? 10 : 14)
                    .foregroundStyle(value ? .successLight : .failureLight)
                    .overlay(
                        Circle().stroke(value ? .successHeavy : .failureHeavy, lineWidth: 2)
                    )
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(complianceType.title),
                message: Text(complianceType.getInfo(value)),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}


struct ListingCard: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @State private var isShowingListingPage = false
    
    let listing: Listing
    
    init(_ listing: Listing) {
        self.listing = listing
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
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
                                .frame(width: 296, height: 348)
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
                                .frame(width: 296, height: 348)
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
                    .frame(width: 296, height: 348) // Ensure image takes the correct size
                } else {
                    // Fallback if no image is available
                    Image(.burrusHall)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 296, height: 348)
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
            }.onTapGesture {
                    isShowingListingPage = true
                }.navigationDestination(isPresented: $isShowingListingPage) {
                    ListingPage(listing: listing).environmentObject(screen)
                }
            
            
            Button {
                // TODO toggle bookmark
                print("bookmark")
            } label: {
                ZStack {
                    Image(.bookmark)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.glassText)
                    
                }.frame(width: 48, height: 48)
                    .glassEffect()
                    .padding(Screen.padding)
            }
            
            VStack {
                HStack(spacing: Screen.halfPadding) {
                    ForEach(ComplianceType.allComplianceTypes, id: \.title) { compliance in
                        ComplianceButton(
                            uiDesignType: .glass,
                            complianceType: compliance,
                            listing: listing
                        )
                    }
                }
                Spacer()
            }.frame(maxHeight: .infinity)
                .padding(Screen.padding)

            // Text content on top of the image and gradient
            VStack(alignment: .leading, spacing: 4) {
                Text("\(listing.bedroomCount) bed, \(listing.bathroomCount) bath at \(listing.apartmentComplexName)")
                    .font(.cardTitle)
                    .foregroundStyle(.glassText)
                Text("$\(listing.price)")
                    .font(.heading)
                    .foregroundStyle(.glassText)
                + Text("/\(listing.period)")
                    .font(.subheading)
                    .foregroundStyle(.glassSecondaryText)
            }.padding(Screen.padding)
                .padding(.trailing, Screen.padding + 48)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
        }
        .frame(width: 296, height: 348) // Fixed size for the card
        .cornerRadius(40) // Rounded corners for the card
    }
}

#Preview {
    ListingCard(Listing.sampleListings[0])
}
