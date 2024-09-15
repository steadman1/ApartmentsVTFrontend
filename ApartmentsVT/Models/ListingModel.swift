//
//  ListingModel.swift
//  ApartmentsVT
//
//  Created by Spencer Steadman on 9/14/24.
//

import Foundation

// MARK: - Listing Model

struct ListingsResponse: Codable {
    let listings: [Listing]
    let success: Bool
}

class Listing: Codable {
    var id: Int
    var userID: Int
    var title: String
    var apartmentComplexName: String
    var price: Int
    var period: String
    var roommateCount: Int
    var summary: String
    var roommateBio: String
    var presentPetTypes: [String]
    var propertyType: String
    var latitude: Float
    var longitude: Float
    var favoriteListing: Bool
    var milesToCampus: Double
    var walkTime: Int
    var bikeTime: Int
    var busRoutesCount: Int
    var driveTime: Int
    var gender: [String]?
    var nationality: [String]?
    var adaAccessible: Bool
    var proximityToStores: [String]
    var rentPeriodStart: String
    var rentPeriodEnd: String
    var leaseLength: String
    var utilitiesIncluded: [String]
    var furnished: Bool
    var squareFootage: Int
    var bathroomCount: Int
    var bedroomCount: Int
    var petsAllowed: Bool
//    var postPublishedDate: Date
    var depositRequired: Int
    var leaseType: String
    var imagesURLs: [URL]
    var urlToListing: String
    var smokingAllowed: Bool
    var parkingAvailable: Bool
    var customFields: [String: String]
    
    init(id: Int, 
         userID: Int,
         title: String,
         apartmentComplexName: String,
         price: Int,
         period: String,
         roommateCount: Int,
         summary: String,
         roommateBio: String,
         presentPetTypes: [String],
         propertyType: String,
         latitude: Float,
         longitude: Float,
         favoriteListing: Bool,
         milesToCampus: Double, 
         walkTime: Int,
         bikeTime: Int,
         busRoutesCount: Int,
         driveTime: Int,
         gender: [String]? = nil,
         nationality: [String]? = nil,
         adaAccessible: Bool,
         proximityToStores: [String],
         rentPeriodStart: String,
         rentPeriodEnd: String,
         leaseLength: String,
         utilitiesIncluded: [String],
         furnished: Bool,
         squareFootage: Int,
         bathroomCount: Int,
         bedroomCount: Int,
         petsAllowed: Bool,
//         postPublishedDate: Date,
         depositRequired: Int,
         leaseType: String,
         imagesURLs: [URL],
         urlToListing: String,
         smokingAllowed: Bool,
         parkingAvailable: Bool,
         customFields: [String : String]) {
        self.id = id
        self.userID = userID
        self.title = title
        self.apartmentComplexName = apartmentComplexName
        self.price = price
        self.period = period
        self.roommateCount = roommateCount
        self.summary = summary
        self.roommateBio = roommateBio
        self.presentPetTypes = presentPetTypes
        self.propertyType = propertyType
        self.latitude = latitude
        self.longitude = longitude
        self.favoriteListing = favoriteListing
        self.milesToCampus = milesToCampus
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
//        self.postPublishedDate = postPublishedDate
        self.depositRequired = depositRequired
        self.leaseType = leaseType
        self.imagesURLs = imagesURLs
        self.urlToListing = urlToListing
        self.smokingAllowed = smokingAllowed
        self.parkingAvailable = parkingAvailable
        self.customFields = customFields
    }
    
    // Custom CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case apartmentComplexName = "apartment_complex_name"
        case price
        case period
        case roommateCount = "roommate_count"
        case summary
        case roommateBio = "roommate_bio"
        case presentPetTypes = "present_pet_types"
        case propertyType = "property_type"
        case latitude
        case longitude
        case milesToCampus = "milesToCampus"
        case favoriteListing = "favoriteListing"
        case walkTime = "walk_time"
        case bikeTime = "bike_time"
        case busRoutesCount = "bus_routes_count"
        case driveTime = "drive_time"
        case gender
        case nationality
        case adaAccessible = "ada_accessible"
        case proximityToStores = "proximity_to_stores"
        case rentPeriodStart = "rent_period_start"
        case rentPeriodEnd = "rent_period_end"
        case leaseLength = "lease_length"
        case utilitiesIncluded = "utilities_included"
        case furnished
        case squareFootage = "square_footage"
        case bathroomCount = "bathroom_count"
        case bedroomCount = "bedroom_count"
        case petsAllowed = "pets_allowed"
//        case postPublishedDate = "post_published_date"
        case depositRequired = "deposit_required"
        case leaseType = "lease_type"
        case imagesURLs = "images_urls"
        case urlToListing = "url_to_listing"
        case smokingAllowed = "smoking_allowed"
        case parkingAvailable = "parking_available"
        case customFields = "custom_fields"
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
    
    static let sampleListings: [Listing] = [
        Listing(
            id: 1,
            userID: 123,
            title: "Spacious 2 Bed Apartment near Campus",
            apartmentComplexName: "Campus Heights",
            price: 1200,
            period: "month",
            roommateCount: 1,
            summary: "A great 2-bedroom apartment close to campus with lots of amenities.",
            roommateBio: "Friendly roommate studying Computer Science at VT.",
            presentPetTypes: ["Dog"],
            propertyType: "Apartment",
            latitude: 37.227,
            longitude: -80.422, 
            favoriteListing: true,
            milesToCampus: 2,
            walkTime: 15,
            bikeTime: 8,
            busRoutesCount: 3,
            driveTime: 5,
            gender: ["Male"],
            nationality: ["American"],
            adaAccessible: true,
            proximityToStores: ["Walmart", "Starbucks", "McDonald's"],
            rentPeriodStart: Date().description,
            rentPeriodEnd: Calendar.current.date(byAdding: .month, value: 12, to: Date())!.description,
            leaseLength: "12 months",
            utilitiesIncluded: ["Water", "Electricity", "Internet"],
            furnished: true,
            squareFootage: 1200,
            bathroomCount: 2,
            bedroomCount: 2,
            petsAllowed: true,
//            postPublishedDate: Date(),
            depositRequired: 500,
            leaseType: "Full Lease",
            imagesURLs: [URL(string: "https://i0.wp.com/www.bsbdesign.com/wp-content/uploads/2023/06/Greystar_UnionBlacksburg_Bldg1Streetscape1.2.jpg?w=2000&ssl=1")!],
            urlToListing: "https://example.com/listings/apartment1",
            smokingAllowed: false,
            parkingAvailable: true,
            customFields: ["Pool": "Yes", "Gym": "Yes"]
        ),
        Listing(
            id: 2,
            userID: 123,
            title: "3 Bed House with Huge Backyard",
            apartmentComplexName: "Union Blacksburg",
            price: 600,
            period: "week",
            roommateCount: 2,
            summary: "A lovely house with a big backyard and close to campus.",
            roommateBio: "Two roommates who love hiking and gaming.",
            presentPetTypes: ["Cat"],
            propertyType: "House",
            latitude: 37.229,
            longitude: -80.421, 
            favoriteListing: false,
            milesToCampus: 3,
            walkTime: 20,
            bikeTime: 10,
            busRoutesCount: 2,
            driveTime: 8,
            gender: ["Female"],
            nationality: ["American", "Canadian"],
            adaAccessible: false,
            proximityToStores: ["Target", "Chipotle"],
            rentPeriodStart: Date().description,
            rentPeriodEnd: Calendar.current.date(byAdding: .month, value: 6, to: Date())!.description,
            leaseLength: "6 months",
            utilitiesIncluded: ["Water", "Electricity"],
            furnished: true,
            squareFootage: 1500,
            bathroomCount: 3,
            bedroomCount: 3,
            petsAllowed: true,
//            postPublishedDate: Date(),
            depositRequired: 600,
            leaseType: "Sublease",
            imagesURLs: [URL(string: "https://i0.wp.com/www.bsbdesign.com/wp-content/uploads/2023/06/Greystar_UnionBlacksburg_Bldg1Streetscape1.2.jpg?w=2000&ssl=1")!],
            urlToListing: "https://example.com/listings/house1",
            smokingAllowed: false,
            parkingAvailable: true,
            customFields: ["Backyard": "Huge", "Garage": "Yes"]
        )
    ]
    
    static let favoriteListings: [Listing] = [
        Listing(
            id: 3,
            userID: 123,
            title: "Cozy 1 Bed Apartment with Stunning Views",
            apartmentComplexName: "The Vista",
            price: 900,
            period: "month",
            roommateCount: 0,
            summary: "A cozy 1-bedroom apartment with great views of the mountains.",
            roommateBio: "",
            presentPetTypes: [],
            propertyType: "Apartment",
            latitude: 37.235,
            longitude: -80.430, 
            favoriteListing: false,
            milesToCampus: 5,
            walkTime: 10,
            bikeTime: 5,
            busRoutesCount: 1,
            driveTime: 3,
            gender: nil,
            nationality: nil,
            adaAccessible: true,
            proximityToStores: ["Trader Joe's", "Whole Foods"],
            rentPeriodStart: Date().description,
            rentPeriodEnd: Calendar.current.date(byAdding: .month, value: 12, to: Date())!.description,
            leaseLength: "12 months",
            utilitiesIncluded: ["Water", "Internet"],
            furnished: true,
            squareFootage: 800,
            bathroomCount: 1,
            bedroomCount: 1,
            petsAllowed: false,
//            postPublishedDate: Date(),
            depositRequired: 400,
            leaseType: "Full Lease",
            imagesURLs: [URL(string: "https://i0.wp.com/www.bsbdesign.com/wp-content/uploads/2023/06/Greystar_UnionBlacksburg_Bldg1Streetscape1.2.jpg?w=2000&ssl=1")!],
            urlToListing: "https://example.com/listings/vista1",
            smokingAllowed: false,
            parkingAvailable: true,
            customFields: ["View": "Mountain"]
        )
    ]
    
//    func getListings() {
//        let host = ObservableDefaults.shared.host
//        
//    }
}

