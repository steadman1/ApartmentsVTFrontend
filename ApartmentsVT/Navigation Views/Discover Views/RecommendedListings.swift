import Foundation
import SwiftUI
import SteadmanUI

struct RecommendedListingType {
    let title: String
    let info: String
    
    static let nearCampus: RecommendedListingType = RecommendedListingType(
        title: "Near Campus",
        info: "Properties within 3 miles of your campus."
    )
    
    static let nearGroceries: RecommendedListingType = RecommendedListingType(
        title: "Near Groceries",
        info: "Properties within 3 miles of at least one grocery store."
    )
}

struct RecommendedListings: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @State var listings: [Listing] = Listing.sampleListings
    
    let type: RecommendedListingType
    @State private var showAlert = false // State variable to control alert presentation
    
    var body: some View {
        VStack(spacing: Screen.padding) {
            HStack {
                Text(type.title)
                    .font(.cardTitle)
                    .foregroundStyle(Color.primaryText)
                
                // Info button to trigger the alert
                Button {
                    showAlert = true // Show the alert when the button is clicked
                } label: {
                    Image(systemName: "info.circle")
                        .font(.detailIcon)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.primaryText)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(type.title),
                        message: Text(type.info),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Spacer()
                
                // See More button
                Button {
                    // TODO: add see more functionality
                } label: {
                    HStack(spacing: 2) {
                        Text("See More")
                            .font(.detail)
                            .foregroundStyle(Color.primaryText)
                        Image(systemName: "arrow.up.forward")
                            .font(.detailIcon)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primaryText)
                    }
                    .padding(.horizontal, Screen.padding)
                    .padding(.vertical, Screen.halfPadding)
                    .background(.middleground)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                }
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, Screen.padding)
            
            // Horizontal ScrollView for listings
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer().frame(width: Screen.padding)
                    ForEach(listings, id: \.id) { listing in
                        ListingCard(listing)
                    }
                }
            }
        }
    }
}
