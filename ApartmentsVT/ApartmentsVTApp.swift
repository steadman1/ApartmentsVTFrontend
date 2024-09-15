//
//  ApartmentsVTApp.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import SwiftUI
import SwiftData
import SteadmanUI

@main
struct ApartmentsVTApp: App {
    @ObservedObject var defaults = ObservableDefaults.shared
    @ObservedObject var screen = Screen.shared
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                NavigationStack {
                    ContentView()
                        .environmentObject(screen)
                        .environmentObject(defaults)
                        .onAppear {
                            screen.width = geometry.size.width
                            screen.height = geometry.size.height
                            screen.safeAreaInsets = geometry.safeAreaInsets
                            screen.initialSafeAreaInsets = geometry.safeAreaInsets
                            

                            refreshJWTToken()
                        }.onChange(of: geometry.size) { _, newValue in
                            screen.width = geometry.size.width
                            screen.height = geometry.size.height
                            screen.safeAreaInsets = geometry.safeAreaInsets
                        }
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}

extension ApartmentsVTApp {
    func refreshJWTToken() {
        // Ensure the refresh token is available
        guard let refreshToken = ObservableDefaults.shared.refreshToken else {
            print("No refresh token available.")
            return
        }

        // Base URL from ObservableDefaults
        guard let host = ObservableDefaults.shared.host else {
            print("Host URL not available")
            return
        }

        // Construct the refresh token URL
        guard let url = URL(string: "\(host)/auth/refresh") else {
            print("Invalid URL")
            return
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set content type to JSON
        request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [:]

        // Encode the body as JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            return
        }

        // Send the request to refresh the token
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            // Handle response
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")

                // Check if the status code indicates success (200 OK)
                if httpResponse.statusCode == 200 {
                    // Handle the response data (access_token and refresh_token)
                    if let data = data {
                        do {
                            // Parse the JSON response
                            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                if let accessToken = jsonResponse["access_token"] as? String,
                                   let newRefreshToken = jsonResponse["refresh_token"] as? String {
                                    // Store new tokens in ObservableDefaults
                                    DispatchQueue.main.async {
                                        ObservableDefaults.shared.accessToken = accessToken
                                        ObservableDefaults.shared.refreshToken = newRefreshToken
                                        print("Tokens refreshed successfully.")
                                    }
                                } else {
                                    print(jsonResponse)
                                    print("Error: Invalid response format.")
                                }
                            }
                        } catch {
                            print("Error decoding response: \(error.localizedDescription)")
                        }
                    }
                } else {
                    print("Failed to refresh token. Status code: \(httpResponse.statusCode)")
                }
            }
        }

        // Start the data task
        task.resume()
    }
}
