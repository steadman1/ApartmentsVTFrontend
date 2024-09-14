//
//  ListingModel.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation

// MARK: - Listing Model

class Listing: Codable {
    var uuid: String
    var userUUID: String // Reference to the user's UUID
    var title: String
    var apartmentComplexName: String
    var price: Int
    var roommateCount: Int
    var summary: String
    var roommateBio: String
    var presentPetTypes: [String]
    var propertyType: String
    var latitude: Float
    var longitude: Float
    var walkTime: Int
    var bikeTime: Int
    var busRoutesCount: Int
    var driveTime: Int
    var gender: [String]?
    var nationality: [String]?
    var adaAccessible: Bool
    var proximityToStores: [String]
    var rentPeriodStart: Date
    var rentPeriodEnd: Date
    var leaseLength: String
    var utilitiesIncluded: [String]
    var furnished: Bool
    var squareFootage: Int
    var bathroomCount: Int
    var bedroomCount: Int
    var petsAllowed: Bool
    var postPublishedDate: Date
    var depositRequired: Int
    var leaseType: String
    var imagesURLs: [URL]
    var urlToListing: String
    var smokingAllowed: Bool
    var parkingAvailable: Bool
    var customFields: [String: String]
    
    init(uuid: String,
         userUUID: String,
         title: String,
         apartmentComplexName: String,
         price: Int,
         roommateCount: Int,
         summary: String,
         roommateBio: String,
         presentPetTypes: [String],
         propertyType: String,
         latitude: Float,
         longitude: Float,
         walkTime: Int,
         bikeTime: Int,
         busRoutesCount: Int,
         driveTime: Int,
         gender: [String]? = nil,
         nationality: [String]? = nil,
         adaAccessible: Bool,
         proximityToStores: [String],
         rentPeriodStart: Date,
         rentPeriodEnd: Date,
         leaseLength: String,
         utilitiesIncluded: [String],
         furnished: Bool,
         squareFootage: Int,
         bathroomCount: Int,
         bedroomCount: Int,
         petsAllowed: Bool,
         postPublishedDate: Date,
         depositRequired: Int,
         leaseType: String,
         imagesURLs: [URL],
         urlToListing: String,
         smokingAllowed: Bool,
         parkingAvailable: Bool,
         customFields: [String: String]) {
        
        self.uuid = uuid
        self.userUUID = userUUID
        self.title = title
        self.apartmentComplexName = apartmentComplexName
        self.price = price
        self.roommateCount = roommateCount
        self.summary = summary
        self.roommateBio = roommateBio
        self.presentPetTypes = presentPetTypes
        self.propertyType = propertyType
        self.latitude = latitude
        self.longitude = longitude
        self.walkTime = walkTime
        self.bikeTime = bikeTime
        self.busRoutesCount = busRoutesCount
        self.driveTime = driveTime
        self.gender = gender
        self.nationality = nationality
        self.adaAccessible = adaAccessible
        self.proximityToStores = proximityToStores
        self.rentPeriodStart = rentPeriodStart
        self.rentPeriodEnd = rentPeriodEnd
        self.leaseLength = leaseLength
        self.utilitiesIncluded = utilitiesIncluded
        self.furnished = furnished
        self.squareFootage = squareFootage
        self.bathroomCount = bathroomCount
        self.bedroomCount = bedroomCount
        self.petsAllowed = petsAllowed
        self.postPublishedDate = postPublishedDate
        self.depositRequired = depositRequired
        self.leaseType = leaseType
        self.imagesURLs = imagesURLs
        self.urlToListing = urlToListing
        self.smokingAllowed = smokingAllowed
        self.parkingAvailable = parkingAvailable
        self.customFields = customFields
    }
    
    // Encoding to JSON Data
    func toJSON() -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Adjust if necessary
        do {
            return try encoder.encode(self)
        } catch {
            print("Error encoding Listing to JSON: \(error)")
            return nil
        }
    }
    
    // Decoding from JSON Data
    static func fromJSON(_ data: Data) -> Listing? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Adjust if necessary
        do {
            return try decoder.decode(Listing.self, from: data)
        } catch {
            print("Error decoding Listing from JSON: \(error)")
            return nil
        }
    }
}

