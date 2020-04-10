//
//  Utils.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import Alamofire
import Foundation
import Kingfisher
import Reachability
import MessageUI
import UIKit
import SwiftMessages


class Utils{
    
    static let reachablity = try! Reachability()
    static let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let imagePlaceholder = #imageLiteral(resourceName: "Gallery-placeholder")
    
    static func isNetworkReachable()->Bool{
        return reachablity.connection != .unavailable
    }
    
    static func setRemoteImageOn(_ imageView:UIImageView, url:String?, placeholder:UIImage? = imagePlaceholder, forceDownload: Bool = false){
        
        if let imageUrl = url, let URL = URL(string: imageUrl ) {
            var options: KingfisherOptionsInfo = []
            options.append(KingfisherOptionsInfoItem.transition(.fade(1)))
            if forceDownload {
                options.append(KingfisherOptionsInfoItem.forceRefresh)
            }
            imageView.kf.setImage(with: URL,
                                  placeholder: placeholder,
                                  options: options)
        } else {
            imageView.image = placeholder
        }
    }
    
    class func EmptyMessage(message:String, table: UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: table.bounds.size.width, height: table.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.9624828696, green: 0.3944129348, blue: 0.123435013, alpha: 1)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        table.backgroundView = messageLabel;
        table.separatorStyle = .none;
        
    }
 
    static func showErrorSnackbar(withTitle: String? = "", message: String) {
        let error = MessageView.viewFromNib(layout: .messageView)
        error.configureTheme(.error)
        error.configureContent(title: withTitle!, body: message)
        error.button?.isHidden = true
        error.configureDropShadow()
//        SwiftMessages.sharedInstance.defaultConfig.dimMode = .none
//        SwiftMessages.sharedInstance.defaultConfig.duration = .seconds(seconds: 3)
        SwiftMessages.show(view: error)
    }
    
    static func showSuccessSnackbar(withTitle: String? = "", message: String) {
        let success = MessageView.viewFromNib(layout: .messageView)
        success.configureTheme(.success)
        success.configureContent(title: withTitle!, body: message)
        success.configureDropShadow()
        success.button?.isHidden = true
//        SwiftMessages.sharedInstance.defaultConfig.dimMode = .none
//        SwiftMessages.sharedInstance.defaultConfig.duration = .seconds(seconds: 3)
        SwiftMessages.show(view: success)
    }
    
    static func showProgress(message : String = "Loading ...", animated : Bool = true, dissmissable:Bool = false){
        DispatchQueue.main.async {
            
            if let topVC = UIApplication.getTopViewController(){
                MBProgressHUD.showAdded(to: topVC.view, animated: true)
                }
        }
    }
    
    static func hideProgress(){
        DispatchQueue.main.async {
            if let topVC = UIApplication.getTopViewController(){
                MBProgressHUD.hide(for: topVC.view, animated: true)
                }
            }
        }

}
