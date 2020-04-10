//
//  LoginViewController.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mobileNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        if isValidPhone(phone: mobileNumber.text ?? "") {
            Login()
        } else {
            Utils.showErrorSnackbar(message: "Invalid phone number.")
        }
    }
    


    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }
    
    func Login() {
        Utils.showProgress()
        let param = ["mobile" : mobileNumber.text ?? ""]
        NetworkManager.sharedManager.login(parameters: param) { (response) in
            Utils.hideProgress()
            if response?.status == 200 {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let OTPViewController = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                    OTPViewController.mobileNumber = self.mobileNumber.text ?? ""
                    self.navigationController?.pushViewController(OTPViewController, animated: true)
                }
            }
        }
    }
    
    func dummy() {
       let headers = [
          "Content-Type": "application/json",
          "cache-control": "no-cache",
          "Postman-Token": "66a60cfc-2aa2-44c9-8a78-5c76e3d75c61"
        ]
        let parameters = ["mobile": "9846214687"] as [String : Any]

        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://mydata4life-api.igrant.io/v1/auth/otp/send/")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            let jsonResponse = try! JSONSerialization.jsonObject(with:
                data!, options: [])
            print(jsonResponse) //Response result
            print(httpResponse)
          }
        })

        dataTask.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
