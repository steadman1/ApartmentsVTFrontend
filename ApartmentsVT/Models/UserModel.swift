//
//  UserModel.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation

// MARK: - User Model

class User: Codable {
    var uuid: String
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var password: String
    var bio: String?
    var nationality: String?
    var profilePictureURL: URL?
    var userListings: [Listing]
    var favoriteListings: [Listing]
    
    init(uuid: String,
         username: String,
         firstName: String,
         lastName: String,
         email: String,
         phoneNumber: String,
         password: String,
         bio: String? = nil,
         nationality: String? = nil,
         profilePictureURL: URL? = nil,
         userListings: [Listing] = [],
         favoriteListings: [Listing] = []) {
        self.uuid = uuid
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
        self.bio = bio
        self.nationality = nationality
        self.profilePictureURL = profilePictureURL
        self.userListings = userListings
        self.favoriteListings = favoriteListings
    }
    
    // Encoding to JSON Data
    func toJSON() -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Adjust if necessary
        do {
            return try encoder.encode(self)
        } catch {
            print("Error encoding User to JSON: \(error)")
            return nil
        }
    }
    
    // Decoding from JSON Data
    static func fromJSON(_ data: Data) -> User? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Adjust if necessary
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            print("Error decoding User from JSON: \(error)")
            return nil
        }
    }
}
