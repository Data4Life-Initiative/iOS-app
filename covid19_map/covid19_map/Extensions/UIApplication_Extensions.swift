//
//  UIApplication_Extensions.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 08/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import Foundation

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
