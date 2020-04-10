//
//  AccountDetailViewController.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 07/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import UIKit

class AccountDetailViewController: UIViewController {

    @IBOutlet weak var healthStatusTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var locationStatusLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    var healthStatusData = ["Healthy", "Not Infected", "Immunized", "Infected With Symptoms", "Infected Without Symptoms"]
    var healthStautsPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthStatusTextField.delegate = self
        healthStatusTextField.inputView = healthStautsPicker
        healthStautsPicker.delegate = self
        let rightViewDownArrow = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: healthStatusTextField.frame.height))
        rightViewDownArrow.image =  #imageLiteral(resourceName: "Dropdown-arrow")
        healthStatusTextField.rightView = rightViewDownArrow
        healthStatusTextField.rightViewMode = .always
        // Do any additional setup after loading the view.
    }
    
    @IBAction func locationSwitchValueChanged(_ sender: Any) {
        if locationSwitch.isOn {
            locationStatusLabel.text = "Enabled"
        } else {
            locationStatusLabel.text = "Disabled"
        }
        
    }
    @IBAction func historicButtonTapped(_ sender: Any) {
    }
    
    @IBAction func evaluateRiskScoreButtonTapped(_ sender: Any) {
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

extension AccountDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        healthStatusData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return healthStatusData[row]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == healthStatusTextField {
                  textField.text = healthStatusData[healthStautsPicker.selectedRow(inComponent: 0)]
              }
    }
}
