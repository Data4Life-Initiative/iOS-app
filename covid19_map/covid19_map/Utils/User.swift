//
//  User.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class User {
    static let shared = User()
    private init(){return}
    
    func isUserAvailable() -> Bool{
        if KeychainWrapper.standard.string(forKey: "covid19_Auth") != nil {
            return true
        }
        return false
    }
    
    func getAuthKey() -> String {
        if let auth = KeychainWrapper.standard.string(forKey: "covid19_Auth") {
            return auth
        }
        return ""
    }
    
    func deleteAuth() {
        KeychainWrapper.standard.removeObject(forKey: "covid19_Auth")
        KeychainWrapper.standard.removeObject(forKey: "mobileNumber")
    }
    
    func saveData(auth: String, mobileNumber: String) {
        KeychainWrapper.standard.set(auth, forKey: "covid19_Auth")
       KeychainWrapper.standard.set(mobileNumber, forKey: "mobileNumber")
    }
}
