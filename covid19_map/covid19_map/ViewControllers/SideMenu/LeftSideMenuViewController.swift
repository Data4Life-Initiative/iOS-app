//
//  LeftSideMenuViewController.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 05/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import UIKit
import SideMenu

class LeftSideMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissMenu: UIButton!
    let sideMenuData = ["HOME", "ACCOUNT", "NOTIFICATIONS", "DATA PREFERENCES", "ABOUT", "LOGOUT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    @IBAction func dismissMenuButtonTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion:  nil)
    }
}

extension LeftSideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sideMenuData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.dismiss(animated: false, completion:  nil)

        switch indexPath.row {
        case 0:
            break
        case 1:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AccountDetailViewController") as! AccountDetailViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)

        case 2:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)

        case 5:
            _ = User.shared.deleteAuth()
            break
        default:
            break
        }
    }
    
    
}
