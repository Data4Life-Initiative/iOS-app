//
//  NetworkManager.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    
    static let sharedManager = NetworkManager()
    
    //Blocking the initializer to outside of class
    private init(){
    }
   
    func fetchDataFromServer<T:Codable>(requestType: HTTPMethod,url:URLConvertible,parameters:Parameters?,headers: [String:String]?,completion:@escaping (T?) -> Void){
        
        //Network Availablity Check
        guard Utils.isNetworkReachable() else{
            Utils.showErrorSnackbar(message:"No Internet, Please try again")
            Utils.hideProgress()
            //completion(nil)
            return
        }
        var headerDict = headers ?? [:]
        headerDict["Authorization"] = "Bearer \(User.shared.getAuthKey())"
        
        AF.request(url,method: requestType, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders.init(headerDict ?? [:])).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let data):
                completion(data)
                break
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                Utils.hideProgress()
                //Utils.showErrorSnackbar(message:"something went wrong, Please try again")
                completion(nil)
            }
        }
    }
    
}

