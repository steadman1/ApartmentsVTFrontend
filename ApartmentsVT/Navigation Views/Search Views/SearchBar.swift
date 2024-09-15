import SwiftUI
import SteadmanUI

struct SearchBar: View {
    @FocusState private var textFieldFocus: Bool // Manages the focus of the TextEditor
    
    @Binding var listings: [Listing]
    
    @Binding var searchQuery: String
    @State private var isLoading = false
    @State private var textEditorHeight: CGFloat = 36
    @State private var textFieldFocusAnimator = false // Animation state for focus
    
    let isEditing: Bool // Determines if editing should be toggled when appearing
    
    let clear: Color = Color.white.opacity(0.000001)
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .trailing) {
                    HStack {
                        Image(.magnifyingglass)
                            .font(.icon)
                            .foregroundStyle(Color.primaryText)
                        
                        ZStack(alignment: .topLeading) {
                            Text(searchQuery)
                                .font(.subtitle)
                                .padding(5)
                                .foregroundColor(clear)
                                .lineLimit(1...10)
                                .background(GeometryReader {
                                    clear.opacity(0.000001).preference(key: ViewHeightKey.self,
                                                           value: $0.frame(in: .local).size.height)
                                })
                            TextEditor(text: $searchQuery)
                                .focused($textFieldFocus) // Link TextEditor focus state
                                .font(.subtitle)
                                .frame(height: max(36, textEditorHeight))
                            if (searchQuery.isEmpty) {
                                VStack(alignment: .leading) {
                                    Text("Smart Search")
                                        .font(.subtitle)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.primaryText)
                                    Text("Search for listings with natural language.")
                                        .font(.detail)
                                        .foregroundStyle(Color.primaryText)
                                }
                            }
                        }.onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
                        DismissingKeyboardButton(textFieldFocus: $textFieldFocus)
                            .foregroundStyle(Color.primaryText)
                    }.padding(Screen.padding)
                        .frame(maxWidth: .infinity)
                        .background(.middleground)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        .padding(.horizontal, Screen.padding)
                    
                    HStack {
                        if (!searchQuery.isEmpty) {
                            ZStack {
                                Text("Submit to show results for \"\(searchQuery)\"")
                                    .font(.detail)
                                    .foregroundStyle(Color.primaryText)
                            }.padding(.vertical, Screen.halfPadding + 1.5)
                                .padding(.horizontal, Screen.padding + 1.5)
                                .background(Color.middleground)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: .black.opacity(0.08), radius: 10)
                        }
                        Spacer()
                        Button {
                            searchListings(searchQuery: searchQuery) { retrievedListings, error in
                                if let error = error {
                                    print("Error searching listings: \(error)")
                                } else if let retrievedListings = retrievedListings {
                                    print("Found \(retrievedListings.count) listings:")
                                    listings = retrievedListings
                                }
                                isLoading = false
                            }
                            isLoading.toggle()
                        } label: {
                                ZStack {
                                    if isLoading {
                                        ProgressView()
                                            .frame(height: 20)
                                            .foregroundStyle(Color.glassText)
                                    } else {
                                        Image(.arrow)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 20)
                                            .foregroundStyle(Color.glassText)
                                            .rotationEffect(searchQuery.isEmpty ? .degrees(-100) : .degrees(0))
                                            .animation(.navigationItemBounce, value: searchQuery.isEmpty)
                                    }
                                }.padding(.vertical, Screen.halfPadding + 1.5)
                                .padding(.horizontal, Screen.padding + 1.5)
                                .background(!isLoading ? Color.foreground : Color.middleground)
                                .clipShape(RoundedRectangle(cornerRadius: 100))
                        }.disabled(searchQuery.isEmpty || isLoading)
                            .opacity(searchQuery.isEmpty ? 0 : 1)
                            .animation(.navigationItemBounce, value: searchQuery.isEmpty)
                            
                    }.padding(.horizontal, Screen.padding)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                textFieldFocus = isEditing // Focus the TextEditor if isEditing is true
            }
        }
        .onChange(of: textFieldFocus) { _, newValue in
            // When focus changes, trigger animations or logic
            if newValue {
                // Add any custom behavior on focus change
            }
            withAnimation(.navigationItemBounce) { textFieldFocusAnimator = newValue }
        }
    }
    
    func searchListings(searchQuery: String, completion: @escaping ([Listing]?, Error?) -> Void) {
        // Base URL from ObservableDefaults
        guard let host = ObservableDefaults.shared.host else {
            print("Host URL not available")
            completion(nil, NSError(domain: "HostUnavailable", code: 1, userInfo: [NSLocalizedDescriptionKey: "Host URL is not available"]))
            return
        }
        
        // Construct the search URL
        guard let url = URL(string: "\(host)/search/ai") else {
            print("Invalid URL")
            completion(nil, NSError(domain: "InvalidURL", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the JSON body with the search query
        let body: [String: Any] = [
            "prompt": searchQuery
        ]
        
        // Encode the body as JSON
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            completion(nil, error)
            return
        }
        
        // Create the data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            // Handle response
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                // Check if the status code indicates success (200 OK)
                if httpResponse.statusCode == 200 {
                    // Handle the response data
                    if let data = data {
                        do {
                            print(String(data: data, encoding: .utf8))
                            // Decode the JSON response to the ListingsResponse model
                            let listingsResponse = try JSONDecoder().decode(ListingsResponse.self, from: data)
                            
                            if listingsResponse.success {
                                completion(listingsResponse.listings, nil)
                            } else {
                                let error = NSError(domain: "SearchFailed", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Search failed. Success flag is false."])
                                completion(nil, error)
                            }
                        } catch {
                            print("Error decoding response: \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                } else {
                    print("Search failed with status code: \(httpResponse.statusCode)")
                    let error = NSError(domain: "SearchFailed", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Search failed with status code: \(httpResponse.statusCode)"])
                    completion(nil, error)
                }
            }
        }
        
        // Start the data task
        task.resume()
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
