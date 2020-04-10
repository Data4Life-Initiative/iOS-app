//
//  HeatMapLocationResponse.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 08/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import Foundation

// MARK: - HeatMapLocationResponse
class HeatMapLocationResponse: Codable {
    let status: Int?
    let data: HotspotLocation?

    init(status: Int?, data: HotspotLocation?) {
        self.status = status
        self.data = data
    }
}

// MARK: - DataClass
class HotspotLocation: Codable {
    let diseaseHotspots: [DiseaseHotspot]?

    enum CodingKeys: String, CodingKey {
        case diseaseHotspots = "disease_hotspots"
    }

    init(diseaseHotspots: [DiseaseHotspot]?) {
        self.diseaseHotspots = diseaseHotspots
    }
}

// MARK: - DiseaseHotspot
class DiseaseHotspot: Codable {
    let lat, long, timestamp: String?

    init(lat: String?, long: String?, timestamp: String?) {
        self.lat = lat
        self.long = long
        self.timestamp = timestamp
    }
}
