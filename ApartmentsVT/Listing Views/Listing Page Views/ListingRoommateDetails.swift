import SwiftUI
import SteadmanUI

struct ListingRoommateDetails: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let listing: Listing
    
    var body: some View {
        VStack(alignment: .leading, spacing: Screen.halfPadding) {
            Text("Get to know your new Roommate\(listing.roommateCount > 1 ? "s" : "")")
                .font(.cardTitle)
                .foregroundStyle(Color.primaryText)
            
            Text(listing.roommateBio)
                .font(.detail)
                .foregroundStyle(Color.primaryText)
            
            // Display the pet types sentence
            Text(petSentence(from: listing.presentPetTypes))
                .font(.detail)
                .foregroundStyle(Color.primaryText)
            
            HStack {
                ListingListItem(systemName: "", value: listing.languages?.joined(separator: " & ") ?? "Prefer not to say", description: "Speaking")
                Spacer()
                ListingListItem(systemName: "", value: listing.gender?.joined(separator: " & ") ?? "Prefer not to say", description: "Gender")
                Spacer()
                ListingListItem(systemName: "", value: listing.nationality?.joined(separator: " & ") ?? "Prefer not to say", description: "Nationality")
            }
            .padding(Screen.padding)
        }
        .padding(Screen.padding)
        .frame(width: screen.width)
        .background(Color.middleground)
        .cornerRadius(24, corners: .allCorners)
    }
    
    // Function to generate the pets sentence
    func petSentence(from pets: [String]) -> String {
        // Count occurrences of each pet type
        let petCount = pets.reduce(into: [:]) { counts, pet in
            counts[pet, default: 0] += 1
        }
        
        // Convert the count dictionary into a readable sentence
        let petParts = petCount.map { petType, count -> String in
            switch Int(count) {
            case 1:
                return "one \(petType)"
            case 2:
                return "two \(petType)s"
            default:
                return "\(count) \(petType)s"
            }
        }
        
        // Join the parts into a single sentence
        let petSentence = petParts.joined(separator: ", ")
        return petSentence.isEmpty ? "No pets are present in the apartment." : "Our apartment has \(petSentence)."
    }
}
