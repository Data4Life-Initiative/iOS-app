//
//  LoginResponse.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? newJSONDecoder().decode(LoginResponse.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? newJSONDecoder().decode(LoginResponse.self, from: jsonData)

import Foundation

// MARK: - LoginResponse
class LoginResponse: Codable {
    let status: Int?
    let data: LoginDataClass?

    init(status: Int?, data: LoginDataClass?) {
        self.status = status
        self.data = data
    }
}

// MARK: - DataClass
class LoginDataClass: Codable {
    let msg, accessToken: String?
    let profile: Profile?

    enum CodingKeys: String, CodingKey {
        case msg
        case accessToken = "access_token"
        case profile
    }

    init(msg: String?, accessToken: String?, profile: Profile?) {
        self.msg = msg
        self.accessToken = accessToken
        self.profile = profile
    }
}

// MARK: - Profile
class Profile: Codable {
    let age: Int?
    let mobile: String?
    let home: Home?
    let locationData: [LocationDatum]?
    let infectionStatus: String?

    enum CodingKeys: String, CodingKey {
        case age, mobile, home
        case locationData = "location_data"
        case infectionStatus = "infection_status"
    }

    init(age: Int?, mobile: String?, home: Home?, locationData: [LocationDatum]?, infectionStatus: String?) {
        self.age = age
        self.mobile = mobile
        self.home = home
        self.locationData = locationData
        self.infectionStatus = infectionStatus
    }
}

// MARK: - Home
class Home: Codable {
    let coords: Coords?

    init(coords: Coords?) {
        self.coords = coords
    }
}

// MARK: - Coords
class Coords: Codable {
    let lat, long: String?

    init(lat: String?, long: String?) {
        self.lat = lat
        self.long = long
    }
}

// MARK: - LocationDatum
class LocationDatum: Codable {
    let locationSource: String?
    let locations: [Location]?

    enum CodingKeys: String, CodingKey {
        case locationSource = "location_source"
        case locations
    }

    init(locationSource: String?, locations: [Location]?) {
        self.locationSource = locationSource
        self.locations = locations
    }
}

// MARK: - Location
class Location: Codable {
    let lat, long, timestamp: String?

    init(lat: String?, long: String?, timestamp: String?) {
        self.lat = lat
        self.long = long
        self.timestamp = timestamp
    }
}
