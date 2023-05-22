//
//  ViewController.swift
//  Official E-Levy Calculator
//
//  Created by DaN SoGbEy on 21/05/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var elevyLabelView: UILabel!
    @IBOutlet weak var telcosLabelView: UILabel!
    @IBOutlet weak var totalChargesView: UILabel!
    
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var networkPicker: UIPickerView!
    
    var networkManager : NetworkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        amountTextField.delegate = self
        networkPicker.delegate = self
        networkPicker.dataSource = self;
        networkManager.delegate = self;
        elevyLabelView.text = "E-Levy: \(networkManager.elevy)%";
        telcosLabelView.text = "Telco: \(networkManager.telco)%";
        totalChargesView.text = "Total: \(networkManager.total)%";
    }
    

    @IBAction func calculatePressed(_ sender: UIButton) {
        if let amount = amountTextField.text {
            networkManager.calculateElevyBasedOnNetwork(Double(amount) ?? 0.00, networkManager.selectedNetwork)
        }
        print(amountTextField.text ?? "Empty")
        amountTextField.endEditing(true)
    }
    
}

//MARK: - UITextFieldDelegate
extension ViewController : UITextFieldDelegate,NetworkManagerDelegate {
    func didUpdateElevyCharges(elevy: Elevy) {
        print("Amount To Send \(elevy.amountSent)")
        elevyLabelView.text = "E-Levy: \(elevy.elevy)%";
        telcosLabelView.text = "Telco: \(elevy.telco)%";
        totalChargesView.text = "Total: \(elevy.total)%";
    }
    
    func didFailElevyCharges() {
        print("Error")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(amountTextField.text == ""){
            textField.textColor = UIColor.gray
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.text = "Enter an amount to continue"
            return false;
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let amount = amountTextField.text {
            networkManager.calculateElevyBasedOnNetwork(Double(amount) ?? 0.00, networkManager.selectedNetwork)
        }
        amountTextField.text = ""
    }
    
}

//MARK: - UIPickerViewDataSource
extension ViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
}


//MARK: - UIPickerViewDelegate
extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return networkManager.networks[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRow = networkManager.networks[row]
        networkManager.network = selectedRow;
    }
}
