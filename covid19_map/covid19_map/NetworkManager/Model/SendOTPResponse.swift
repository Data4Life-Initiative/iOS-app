//
//  SendOTPResponse.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import Foundation

// MARK: - SendOTPResponse
class SendOTPResponse: Codable {
    let status: Int
    let data: SendOTPData

    init(status: Int, data: SendOTPData) {
        self.status = status
        self.data = data
    }
}

// MARK: - DataClass
class SendOTPData: Codable {
    let msg: String

    init(msg: String) {
        self.msg = msg
    }
}
//struct SendOTPResponse : Codable {
//    let status : Int?
//    let data : SendOTPData?
//
//    enum CodingKeys: String, CodingKey {
//
//        case status = "status"
//        case data = "data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = try values.decodeIfPresent(Int.self, forKey: .status)
//        data = try values.decodeIfPresent(SendOTPData.self, forKey: .data)
//    }
//
//}
//
//struct SendOTPData : Codable {
//    let msg : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case msg = "msg"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        msg = try values.decodeIfPresent(String.self, forKey: .msg)
//    }
//
//}
