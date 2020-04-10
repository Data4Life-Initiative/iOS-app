//
//  covid19NetworkManager.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "https://mydata4life-api.igrant.io/v1"

enum covid19_API: String {
    
    case login = "/auth/otp/send/"
    case verifyOTP = "/auth/otp/verify/citizen"
    case getHotspots = "/disease/hotspots/"
    
    var URL:String{
           return baseURL + self.rawValue
       }
}

extension NetworkManager {
    func login(parameters: [String: String], completion: @escaping((SendOTPResponse?) -> Void)) {

        let requestURL = covid19_API.login.URL
        fetchDataFromServer(requestType: .post, url: requestURL, parameters: parameters, headers: nil, completion: completion)
    }
    
    func confirmOtp(parameters: [String: String], completion: @escaping((LoginResponse?) -> Void)) {

        let requestURL = covid19_API.verifyOTP.URL
        fetchDataFromServer(requestType: .post, url: requestURL, parameters: parameters, headers: nil, completion: completion)
    }
    
    func getLocationForHeatMap(completion: @escaping((HeatMapLocationResponse?) -> Void)) {

        let requestURL = covid19_API.getHotspots.URL
        fetchDataFromServer(requestType: .get, url: requestURL, parameters: nil, headers: nil, completion: completion)
    }
    
}
