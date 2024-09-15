//
//  Discover.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI
import SteadmanUI

struct DiscoverPage: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    let discoverTopBarHeight: CGFloat = 160
    
    @State var nearGroceries: [Listing] = []
    @State var nearCampus: [Listing] = []
    @State var busRoutes: [Listing] = []
    @State var withoutPets: [Listing] = []
    
    var body: some View {
        let topInset: CGFloat = screen.safeAreaInsets.top + Screen.padding * 3
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: Screen.padding * 2) {
                    RecommendedListings(listings: $nearCampus, type: .nearCampus)
//                    RecommendedListings(listings: $nearGroceries, type: .nearGroceries)
                    RecommendedListings(listings: $busRoutes, type: .busRoutes)
                    RecommendedListings(listings: $withoutPets, type: .withoutPets)
                }.padding(.top, discoverTopBarHeight + topInset - Screen.padding * 2)
                    .padding(.bottom, screen.safeAreaInsets.bottom + Screen.padding * 6)
                    .frame(maxWidth: .infinity)
            }
            DiscoverTopBar(topInset: topInset, height: discoverTopBarHeight)
        }.frame(maxHeight: .infinity)
            .background(Color.background)
            .ignoresSafeArea()
            .onAppear {
                guard let accessToken = defaults.accessToken else { return }
                fetchGroceryListings(accessToken: accessToken) { result in
                    switch result {
                    case .success(let listings):
                        nearGroceries = listings
                    case .failure(let error):
                        print("Failed to fetch grocery listings: \(error.localizedDescription)")
                    }
                }

                // Fetch listings near transport routes
                fetchRouteListings(accessToken: accessToken) { result in
                    switch result {
                    case .success(let listings):
                        busRoutes = listings
                    case .failure(let error):
                        print("Failed to fetch route listings: \(error.localizedDescription)")
                    }
                }
                
                fetchPetsAllowedListings(accessToken: accessToken) { result in
                    switch result {
                    case .success(let listings):
                        withoutPets = listings
                    case .failure(let error):
                        print("Failed to fetch grocery listings: \(error.localizedDescription)")
                    }
                }

                // Fetch listings near transport routes
                fetchNearbyListings(accessToken: accessToken) { result in
                    switch result {
                    case .success(let listings):
                        print("Fetched \(listings.count) route listings")
                        nearCampus = listings
                    case .failure(let error):
                        print("Failed to fetch route listings: \(error.localizedDescription)")
                    }
                }
            }
    }

    // Common function to handle fetch requests for Listings
    func fetchListings(from endpoint: String, accessToken: String, completion: @escaping (Result<[Listing], Error>) -> Void) {
        // Base URL from ObservableDefaults
        guard let host = ObservableDefaults.shared.host else {
            print("Host URL not available")
            completion(.failure(NSError(domain: "HostUnavailable", code: 1, userInfo: [NSLocalizedDescriptionKey: "Host URL is not available"])))
            return
        }
        
        // Construct the URL for the endpoint
        guard let url = URL(string: "\(host)\(endpoint)") else {
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

    // 1. Fetch Listings near groceries
    func fetchGroceryListings(accessToken: String, completion: @escaping (Result<[Listing], Error>) -> Void) {
        fetchListings(from: "/grocery", accessToken: accessToken, completion: completion)
    }

    // 2. Fetch nearby Listings
    func fetchNearbyListings(accessToken: String, completion: @escaping (Result<[Listing], Error>) -> Void) {
        fetchListings(from: "/nearby", accessToken: accessToken, completion: completion)
    }

    // 3. Fetch Listings with pets allowed
    func fetchPetsAllowedListings(accessToken: String, completion: @escaping (Result<[Listing], Error>) -> Void) {
        fetchListings(from: "/pets", accessToken: accessToken, completion: completion)
    }

    // 4. Fetch Listings near public transport routes
    func fetchRouteListings(accessToken: String, completion: @escaping (Result<[Listing], Error>) -> Void) {
        fetchListings(from: "/routes", accessToken: accessToken, completion: completion)
    }

}

