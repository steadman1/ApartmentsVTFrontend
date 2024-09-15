//
//  SearchPage.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct SearchView: View {
    @EnvironmentObject var screen: Screen
    @EnvironmentObject var defaults: ObservableDefaults
    
    @State private var searchQuery = ""
    @State private var listings: [Listing] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                ScrollView {
                    VStack {
                        Spacer().frame(height: Screen.padding * (searchQuery.isEmpty ? 1 : 4))
                        if (!listings.isEmpty) {
                            ForEach(listings, id: \.id) { listing in
                                ListingInline(listing)
                            }
                            
                            Spacer().frame(height: Screen.padding)
                            
                            Text("Found \(listings.count) listings matching query.")
                                .font(.subheading)
                                .foregroundStyle(Color.secondaryText)
                        } else {
                            Text("No Listings Found.")
                                .font(.heading)
                                .foregroundStyle(Color.primaryText)
                        }
                        Spacer().frame(height: screen.safeAreaInsets.bottom + Screen.padding * 6)
                    }.frame(maxWidth: .infinity)
                }
            }.padding(.top, 64)
            SearchBar(listings: $listings, searchQuery: $searchQuery, isEditing: true)
        }.frame(maxHeight: .infinity)
            .background(Color.background)
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                guard let accessToken = defaults.accessToken else { return }
                getAllListings(accessToken: accessToken) { result in
                    switch result {
                    case .success(let retrievedListings):
                        print("Found \(retrievedListings.count) Listings Objects.")
                        listings = retrievedListings
                    case .failure(let error):
                        print("Failed to fetch listings: \(error.localizedDescription)")
                    }
                }
            }
    }

    func getAllListings(accessToken: String, completion: @escaping (Result<[Listing], Error>) -> Void) {
        // Base URL from ObservableDefaults
        guard let host = ObservableDefaults.shared.host else {
            print("Host URL not available")
            completion(.failure(NSError(domain: "HostUnavailable", code: 1, userInfo: [NSLocalizedDescriptionKey: "Host URL is not available"])))
            return
        }
        
        // Construct the URL for the get_all endpoint
        guard let url = URL(string: "\(host)/get_all") else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "InvalidURL", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add the JWT token to the Authorization header
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Create the data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle any errors
            if let error = error {
                print("Error occurred during the request: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Handle the response
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                // Check for a successful status code (200 OK)
                if httpResponse.statusCode == 200 {
                    // Handle the response data
                    if let data = data {
                        do {
                            // Decode the JSON response into an array of Listing objects
                            let listings = try JSONDecoder().decode([Listing].self, from: data)
                            completion(.success(listings)) // Success, returning the array of listings
                        } catch {
                            print("Error decoding Listings from JSON: \(error.localizedDescription)")
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(NSError(domain: "NoData", code: 3, userInfo: [NSLocalizedDescriptionKey: "No data received from server"])))
                    }
                } else {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    completion(.failure(NSError(domain: "RequestFailed", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code: \(httpResponse.statusCode)"])))
                }
            }
        }
        
        // Start the data task
        task.resume()
    }

}

