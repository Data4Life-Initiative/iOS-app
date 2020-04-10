//
//  OTPViewController.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var otpTextField: OTPTextField!
    var mobileNumber: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.isEnabled = false
        otpTextField.otpDelegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        confirmOTP()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func confirmOTP() {
        Utils.showProgress()
        let param = ["mobile" : mobileNumber ?? "", "otp": otpTextField.text ?? ""]
        NetworkManager.sharedManager.confirmOtp(parameters: param) { (response) in
            Utils.hideProgress()
            if response?.status == 200 {
                User.shared.saveData(auth: response?.data?.accessToken ?? "", mobileNumber: self.mobileNumber ?? "")
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(HomeViewController, animated: true)
                }
            }
        }
    }
}

extension OTPViewController: OTPTextFieldDelegate {
    func otpTextField(_ textField: OTPTextField, didChange otpCode: String) {
        if otpCode.count > 5 {
            confirmButton.isEnabled = true
        } else {
            confirmButton.isEnabled = false

        }
    }
    
    
}
