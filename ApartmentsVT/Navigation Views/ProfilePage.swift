//
//  ProfilePage.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation
import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var defaults: ObservableDefaults
    
    var body: some View {
        VStack {
            
        }.onAppear {
            login(email: "steadman@vt.edu", password: "12345") { accessToken, refreshToken, error in
                if let error = error {
                    print("Login error: \(error)")
                } else if let accessToken = accessToken, let refreshToken = refreshToken {
                    defaults.accessToken = accessToken
                    defaults.refreshToken = refreshToken
                    print("Login success")
                    // Save tokens or proceed with authenticated requests
                } else {
                    print("Login failed")
                }
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (String?, String?, Error?) -> Void) {
        // Base URL from ObservableDefaults
        guard let host = ObservableDefaults.shared.host else {
            print("Host URL not available")
            return
        }
        
        // Construct the login URL
        guard let url = URL(string: "\(host)/auth/login") else {
            print("Invalid URL")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set content type to JSON
        
        // Prepare the JSON body with login parameters
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        // Encode the body as JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            return
        }
        
        // Create the data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, nil, error)
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
                                   let refreshToken = jsonResponse["refresh_token"] as? String {
                                    print("Access Token: \(accessToken)")
                                    print("Refresh Token: \(refreshToken)")
                                    completion(accessToken, refreshToken, nil)
                                } else {
                                    print("Error: Invalid response format")
                                    completion(nil, nil, nil)
                                }
                            }
                        } catch {
                            print("Error decoding response: \(error.localizedDescription)")
                            completion(nil, nil, error)
                        }
                    }
                } else {
                    print("Login failed with status code: \(httpResponse.statusCode)")
                    completion(nil, nil, nil)
                }
            }
        }
        
        // Start the data task
        task.resume()
    }


    func signup(firstName: String, lastName: String, username: String, password: String, email: String, phoneNumber: String) {
        // Base URL from ObservableDefaults
        guard let host = ObservableDefaults.shared.host else {
            print("Host URL not available")
            return
        }
        
        // Construct the signup URL
        guard let url = URL(string: "\(host)/auth/signup") else {
            print("Invalid URL")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set content type to JSON
        
        // Prepare the JSON body with signup parameters
        let body: [String: Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "username": username,
            "password": password,
            "email": email,
            "phone_number": phoneNumber
        ]
        
        // Encode the body as JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            return
        }
        
        // Create the data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Handle response
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                // Check if the status code indicates success (200 OK, 201 Created, etc.)
                if (200...299).contains(httpResponse.statusCode) {
                    print("Signup successful!")
                    
                    // Handle the response data (if any)
                    if let data = data {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                            print("Response: \(jsonResponse)")
                        } catch {
                            print("Error decoding response: \(error.localizedDescription)")
                        }
                    }
                } else {
                    print("Signup failed with status code: \(httpResponse.statusCode)")
                }
            }
        }
        
        // Start the data task
        task.resume()
    }

}
