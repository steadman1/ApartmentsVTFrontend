//
//  CreateListingBasicInfo.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/15/24.
//

import SwiftUI
import SteadmanUI
import PhotosUI

struct ImageUploadResponse: Codable {
    let success: Bool
    let imageURL: String
}

struct CreateListingBasicInfo: View {
    @EnvironmentObject var defaults: ObservableDefaults
    @EnvironmentObject var screen: Screen
    
    @Binding var selection: Int
    @Binding var listing: Listing
    
    // Local state variables for image and photo picker
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var priceInput: String = ""
    @State private var selectedPeriod: String = "Month"
    
    // Image upload state
    @State private var isUploading = false
    @State private var imageUploadError: String? = nil
    
    let periods = ["Day", "Week", "Month", "Year"]
    
    var body: some View {
        VStack(spacing: 16) {
            // Title input field
            TextField("Enter listing title", text: $listing.title)
                .font(.title2)
                .padding()
                .background(Color.middleground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, Screen.padding)
            
            // Image picker section
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: screen.width - Screen.padding * 2, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, Screen.padding)
                } else {
                    Button {
                        isImagePickerPresented = true
                    } label: {
                        VStack {
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.primaryText)
                            Text("Add Image")
                                .foregroundStyle(.primaryText)
                        }
                    }
                    .frame(width: screen.width - Screen.padding * 2, height: 200)
                    .background(Color.middleground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, Screen.padding)
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            // Summary input field
            TextEditor(text: $listing.summary)
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
                .placeholder(when: listing.summary.isEmpty) {
                    Text("Enter a summary").foregroundColor(.gray)
                }
            
            // Price input and period picker
            HStack {
                TextField("Price", text: $priceInput)
                    .keyboardType(.decimalPad)
                    .font(.title2)
                    .padding()
                    .background(Color.middleground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, Screen.padding / 2)
                
                Picker("Period", selection: $selectedPeriod) {
                    ForEach(periods, id: \.self) { period in
                        Text(period).tag(period)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, Screen.padding / 2)
            }
            .padding(.horizontal, Screen.padding)
            
            Spacer()
            // Save button
            Button(action: {
                if let price = Int(priceInput) {
                    listing.price = price
                }
                listing.period = selectedPeriod
                
                DispatchQueue.main.async {
                    // Upload image if one is selected
                    if let image = selectedImage {
                        isUploading = true
                        guard let accessToken = defaults.accessToken else { return }

                        // Call the uploadImage function
                        uploadImage(image, accessToken: accessToken) { result in
                            isUploading = false
                            switch result {
                            case .success(let data):
                                do {
                                    // Decode the JSON response into ImageUploadResponse
                                    let imageResponse = try JSONDecoder().decode(ImageUploadResponse.self, from: data.data(using: .utf8)!)
                                    if imageResponse.success {
                                        listing.imagesURLs.append(URL(string: imageResponse.imageURL)!) // Append image URL if success is true
                                    } else {
                                        imageUploadError = "Upload failed. Please try again."
                                    }
                                } catch {
                                    imageUploadError = "Failed to parse image upload response."
                                }
                            case .failure(let error):
                                imageUploadError = error.localizedDescription
                            }
                        }
                    }
                }


                selection += 1
            }) {
                if isUploading {
                    ProgressView("Uploading Image...")
                } else {
                    Text("Continue")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.primary)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, Screen.padding)
                }
            }
            .disabled(isUploading)
        }
        .navigationTitle("Basic Info")
        .padding()
    }

    func uploadImage(_ image: UIImage, accessToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Base URL from ObservableDefaults
        guard let host = ObservableDefaults.shared.host else {
            print("Host URL not available")
            completion(.failure(NSError(domain: "HostUnavailable", code: 1, userInfo: [NSLocalizedDescriptionKey: "Host URL is not available"])))
            return
        }
        
        // Construct the URL for the image upload endpoint
        guard let url = URL(string: "\(host)/images/upload") else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "InvalidURL", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Convert UIImage to Data (JPEG representation)
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            completion(.failure(NSError(domain: "ImageConversionError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        // Create the boundary string for multipart form data
        let boundary = UUID().uuidString
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Create the multipart form data body
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Add the body to the request
        request.httpBody = body
        
        // Create the data task to upload the image
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
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        completion(.success(responseString)) // Success, return the image URL as a string
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

// MARK: - Image Picker Component

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Placeholder Modifier for TextEditor

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

