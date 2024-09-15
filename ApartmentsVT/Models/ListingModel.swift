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

class Listing: Codable, Identifiable {
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
    var languages: [String]?
    var gender: [String]?
    var nationality: [String]?
    var adaAccessible: Bool
    var proximityToStores: [String]
//    var rentPeriodStart: String
//    var rentPeriodEnd: String
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
    var urlToListing: String = ""
    var smokingAllowed: Bool
    var parkingAvailable: Bool
//    var customFields: [String: String] = [:]
    
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
         languages: [String]? = nil,
         gender: [String]? = nil,
         nationality: [String]? = nil,
         adaAccessible: Bool,
         proximityToStores: [String],
//         rentPeriodStart: String,
//         rentPeriodEnd: String,
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
         parkingAvailable: Bool
//         customFields: [String : String]
    ) {
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
        self.languages = languages
        self.gender = gender
        self.nationality = nationality
        self.adaAccessible = adaAccessible
        self.proximityToStores = proximityToStores
//        self.rentPeriodStart = rentPeriodStart
//        self.rentPeriodEnd = rentPeriodEnd
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
//        self.customFields = customFields
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
        case languages
        case gender
        case nationality
        case adaAccessible = "ada_accessible"
        case proximityToStores = "proximity_to_stores"
//        case rentPeriodStart = "rent_period_start"
//        case rentPeriodEnd = "rent_period_end"
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
//        case customFields = "custom_fields"
    }
    
    // Custom decoding initializer to set default for urlToListing
        required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.userID = try container.decode(Int.self, forKey: .userID)
        self.title = try container.decode(String.self, forKey: .title)
        self.apartmentComplexName = try container.decode(String.self, forKey: .apartmentComplexName)
        self.price = try container.decode(Int.self, forKey: .price)
        self.period = try container.decode(String.self, forKey: .period)
        self.roommateCount = try container.decode(Int.self, forKey: .roommateCount)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.roommateBio = try container.decode(String.self, forKey: .roommateBio)
        self.presentPetTypes = try container.decode([String].self, forKey: .presentPetTypes)
        self.propertyType = try container.decode(String.self, forKey: .propertyType)
        self.latitude = try container.decode(Float.self, forKey: .latitude)
        self.longitude = try container.decode(Float.self, forKey: .longitude)
        self.favoriteListing = try container.decode(Bool.self, forKey: .favoriteListing)
        self.milesToCampus = try container.decode(Double.self, forKey: .milesToCampus)
        self.walkTime = try container.decode(Int.self, forKey: .walkTime)
        self.bikeTime = try container.decode(Int.self, forKey: .bikeTime)
        self.busRoutesCount = try container.decode(Int.self, forKey: .busRoutesCount)
        self.driveTime = try container.decode(Int.self, forKey: .driveTime)
        self.languages = try container.decodeIfPresent([String].self, forKey: .languages)
        self.gender = try container.decodeIfPresent([String].self, forKey: .gender)
        self.nationality = try container.decodeIfPresent([String].self, forKey: .nationality)
        self.adaAccessible = try container.decode(Bool.self, forKey: .adaAccessible)
        self.proximityToStores = try container.decode([String].self, forKey: .proximityToStores)
//        self.rentPeriodStart = try container.decode(String.self, forKey: .rentPeriodStart)
//        self.rentPeriodEnd = try container.decode(String.self, forKey: .rentPeriodEnd)
        self.leaseLength = try container.decode(String.self, forKey: .leaseLength)
        self.utilitiesIncluded = try container.decode([String].self, forKey: .utilitiesIncluded)
        self.furnished = try container.decode(Bool.self, forKey: .furnished)
        self.squareFootage = try container.decode(Int.self, forKey: .squareFootage)
        self.bathroomCount = try container.decode(Int.self, forKey: .bathroomCount)
        self.bedroomCount = try container.decode(Int.self, forKey: .bedroomCount)
        self.petsAllowed = try container.decode(Bool.self, forKey: .petsAllowed)
        self.depositRequired = try container.decode(Int.self, forKey: .depositRequired)
        self.leaseType = try container.decode(String.self, forKey: .leaseType)
        self.imagesURLs = try container.decode([URL].self, forKey: .imagesURLs)
        self.urlToListing = try container.decodeIfPresent(String.self, forKey: .urlToListing) ?? "" // Default to empty string
        self.smokingAllowed = try container.decode(Bool.self, forKey: .smokingAllowed)
        self.parkingAvailable = try container.decode(Bool.self, forKey: .parkingAvailable)
//        self.customFields = try container.decode([String: String].self, forKey: .customFields) ?? [:]
    }
    
    // Encoding function if needed
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userID, forKey: .userID)
        try container.encode(title, forKey: .title)
        try container.encode(apartmentComplexName, forKey: .apartmentComplexName)
        try container.encode(price, forKey: .price)
        try container.encode(period, forKey: .period)
        try container.encode(roommateCount, forKey: .roommateCount)
        try container.encode(summary, forKey: .summary)
        try container.encode(roommateBio, forKey: .roommateBio)
        try container.encode(presentPetTypes, forKey: .presentPetTypes)
        try container.encode(propertyType, forKey: .propertyType)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(favoriteListing, forKey: .favoriteListing)
        try container.encode(milesToCampus, forKey: .milesToCampus)
        try container.encode(walkTime, forKey: .walkTime)
        try container.encode(bikeTime, forKey: .bikeTime)
        try container.encode(busRoutesCount, forKey: .busRoutesCount)
        try container.encode(driveTime, forKey: .driveTime)
        try container.encode(gender, forKey: .gender)
        try container.encode(languages, forKey: .languages)
        try container.encode(nationality, forKey: .nationality)
        try container.encode(adaAccessible, forKey: .adaAccessible)
        try container.encode(proximityToStores, forKey: .proximityToStores)
//        try container.encode(rentPeriodStart, forKey: .rentPeriodStart)
//        try container.encode(rentPeriodEnd, forKey: .rentPeriodEnd)
        try container.encode(leaseLength, forKey: .leaseLength)
        try container.encode(utilitiesIncluded, forKey: .utilitiesIncluded)
        try container.encode(furnished, forKey: .furnished)
        try container.encode(squareFootage, forKey: .squareFootage)
        try container.encode(bathroomCount, forKey: .bathroomCount)
        try container.encode(bedroomCount, forKey: .bedroomCount)
        try container.encode(petsAllowed, forKey: .petsAllowed)
        try container.encode(depositRequired, forKey: .depositRequired)
        try container.encode(leaseType, forKey: .leaseType)
        try container.encode(imagesURLs, forKey: .imagesURLs)
        try container.encode(urlToListing, forKey: .urlToListing)
        try container.encode(smokingAllowed, forKey: .smokingAllowed)
        try container.encode(parkingAvailable, forKey: .parkingAvailable)
//        try container.encode(customFields, forKey: .customFields)
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
            languages: ["English"],
            gender: ["Male"],
            nationality: ["American"],
            adaAccessible: true,
            proximityToStores: ["Walmart", "Starbucks", "McDonald's"],
//            rentPeriodStart: Date().description,
//            rentPeriodEnd: Calendar.current.date(byAdding: .month, value: 12, to: Date())!.description,
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
            parkingAvailable: true
//            customFields: ["Pool": "Yes", "Gym": "Yes"]
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
            languages: ["English", "French"],
            gender: ["Female"],
            nationality: ["American", "Canadian"],
            adaAccessible: false,
            proximityToStores: ["Target", "Chipotle"],
//            rentPeriodStart: Date().description,
//            rentPeriodEnd: Calendar.current.date(byAdding: .month, value: 6, to: Date())!.description,
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
            parkingAvailable: true
//            customFields: ["Backyard": "Huge", "Garage": "Yes"]
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
            languages: nil,
            gender: nil,
            nationality: nil,
            adaAccessible: true,
            proximityToStores: ["Trader Joe's", "Whole Foods"],
//            rentPeriodStart: Date().description,
//            rentPeriodEnd: Calendar.current.date(byAdding: .month, value: 12, to: Date())!.description,
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
            parkingAvailable: true
//            customFields: ["View": "Mountain"]
        )
    ]
    
    static let blankListing = Listing(
        id: 0,
        userID: 0,
        title: "",
        apartmentComplexName: "",
        price: 0,
        period: "",
        roommateCount: 0,
        summary: "",
        roommateBio: "",
        presentPetTypes: [],
        propertyType: "",
        latitude: 0.0,
        longitude: 0.0,
        favoriteListing: false,
        milesToCampus: 0.0,
        walkTime: 0,
        bikeTime: 0,
        busRoutesCount: 0,
        driveTime: 0,
        gender: nil,
        nationality: nil,
        adaAccessible: false,
        proximityToStores: [],
//        rentPeriodStart: "",
//        rentPeriodEnd: "",
        leaseLength: "",
        utilitiesIncluded: [],
        furnished: false,
        squareFootage: 0,
        bathroomCount: 0,
        bedroomCount: 0,
        petsAllowed: false,
        depositRequired: 0,
        leaseType: "",
        imagesURLs: [],
        urlToListing: "",
        smokingAllowed: false,
        parkingAvailable: false
//        customFields: [:]
    )
}

