//
//  CreateListing.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI

struct CreateListing: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @State var selection: Int
    @State var listing = Listing.blankListing
    
    let viewNames: [String]
    
    init() {
        self.selection = 0
        self.viewNames = [
            "Basic Info",
            "About Apt.",
            "Compliance",
            "Roommates",
            "Finances"
        ]
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 2) {
                        Spacer().frame(width: Screen.padding - 4)
                        Button {
                            dismiss()
                        } label: {
                            ZStack {
                                Image(systemName: "xmark")
                                    .font(.miniIcon.bold())
                                    .foregroundStyle(.glassText)
                            }.frame(width: 48, height: 48)
                                .background(Color.foreground)
                                .cornerRadius(100, corners: .allCorners)
                        }
                        Spacer().frame(width: Screen.padding - 4 * 2)
                        ForEach(0..<viewNames.count, id: \.self) { index in
                            Button {
                                Screen.impact(enabled: true)
                                withAnimation(.navigationItemBounce) { selection = index }
                            } label: {
                                if selection >= index {
                                    HStack(spacing: 0) {
                                        if selection > index {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 11))
                                                .fontWeight(.black)
                                                .foregroundStyle(Color.glassText)
                                        }
                                        Text(viewNames[index])
                                            .font(.heading)
                                            .foregroundStyle(Color.glassText)
                                            .padding([.leading, .trailing], Screen.halfPadding)
                                    }.padding(Screen.padding)
                                        .background(Color.foreground)
                                        .clipShape(RoundedRectangle(cornerRadius: 100))
                                } else {
                                    ZStack {
                                        Text(viewNames[index])
                                            .font(.heading)
                                            .foregroundStyle(Color.primaryText)
                                    }.padding(Screen.padding)
                                        .background(Color.middleground)
                                        .cornerRadius(100, corners: .allCorners)
                                        
                                }
                            }.id(index)
                            if index < viewNames.count - 1 {
                                RoundedRectangle(cornerRadius: 100)
                                    .frame(width: 12, height: 3)
                                    .foregroundStyle(Color.foreground)
                            } else {
                                Spacer().frame(width: Screen.padding)
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
                //                        .clipShape(RoundedRectangle(cornerRadius: 100))
                    .onChange(of: selection) { _, newValue in
                        if (newValue >= viewNames.count) {
                            createPost(listing: listing) { result in
                                switch result {
                                    case .success(let responseString):
                                        print("Post created successfully: \(responseString)")
                                    case .failure(let error):
                                        print("Failed to create post: \(error.localizedDescription)")
                                    }
                                dismiss()
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.navigationItemBounce) {
                                proxy.scrollTo(newValue, anchor: .center)
                            }
                        }
                    }
            }.frame(width: screen.width)
            
            CreateListingDreamViews(selection: $selection) {
                CreateListingBasicInfo(selection: $selection, listing: $listing)
                CreateListingAptSpecifics(selection: $selection, listing: $listing)
                CreateListingCompliance(selection: $selection, listing: $listing)
                CreateListingRoommates(selection: $selection, listing: $listing)
                CreateListingAptFinances(selection: $selection, listing: $listing)
            }
        }.background(Color.background)
    }

    func createPost(listing: Listing, completion: @escaping (Result<String, Error>) -> Void) {
        // Base URL from ObservableDefaults
        guard let host = defaults.host else {
            print("Host URL not available")
            completion(.failure(NSError(domain: "HostUnavailable", code: 1, userInfo: [NSLocalizedDescriptionKey: "Host URL is not available"])))
            return
        }
        
        // Construct the URL for the create post endpoint
        guard let url = URL(string: "\(host)/posts/create_post") else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "InvalidURL", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add the JWT token to the Authorization header
        guard let accessToken = defaults.accessToken else {
            print("Invalid Access Token")
            completion(.failure(NSError(domain: "InvalidJWTAccessToken", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid JWT Access Token"])))
            return
        }
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Encode the Listing object to JSON data
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Adjust this based on how your backend expects date formats
        do {
            let jsonData = try encoder.encode(listing)
            request.httpBody = jsonData
        } catch {
            print("Error encoding Listing to JSON: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
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
                        if let responseString = String(data: data, encoding: .utf8) {
                            completion(.success(responseString)) // Success, returning the response string
                        } else {
                            completion(.failure(NSError(domain: "ResponseError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])))
                        }
                    } else {
                        completion(.failure(NSError(domain: "NoData", code: 4, userInfo: [NSLocalizedDescriptionKey: "No data received from server"])))
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

struct NewDreamBuilder {
    var name: String
    var content: any View
}

struct CreateListingDreamViews<Content: View>: View {
    @Binding var selection: Int
    var content: Content
    
    init(selection: Binding<Int>,
         @ViewBuilder content: @escaping () -> Content) {
        
        self._selection = Binding(projectedValue: selection)
        self.content = content()
    }
    
    var body: some View {
        Extract(content) { views in
        // ^ from https://github.com/GeorgeElsham/ViewExtractor
            VStack {
                ForEach(Array(zip(views.indices, views)), id: \.0) { index, view in
                    if selection == index {
                        view.id(index).tag(index)
                    }
                }
            }.animation(.navigationItemBounce, value: selection)
        }
    }
}
