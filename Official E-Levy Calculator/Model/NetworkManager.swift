//
//  NetworkManager.swift
//  Official E-Levy Calculator
//
//  Created by DaN SoGbEy on 22/05/2023.
//

import Foundation

protocol NetworkManagerDelegate  {
    func didUpdateElevyCharges(elevy: Elevy)
    func didFailElevyCharges()
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    var amount: Double = 0;
    var telcoCharge: Double = 0;
    var elevyCharge: Double = 0;
    var totalCharge: Double = 0;
    var amountSent: Double = 0;
    
    var telco: Double = 0;
    var elevy: Double = 0;
    var total: Double = 0;
    
    var network : String = "MTN";
    
    var networks : [String]  = ["MTN", "VODAFONE", "AIRTEL/TIGO"]
    
    var selectedNetwork : String {
        print(network)
        return network
    }
    
    mutating func calculateElevyBasedOnNetwork (_ enteredAmount:Double, _ network: String) {
        print(selectedNetwork)
        self.amount = enteredAmount;
        self.network = network;
        
        print("NETWORK \(network)")
        
        
        switch (self.network) {
        case "MTN" :
            self.elevy = 1.5
            self.telco = 0.75
            self.total = self.elevy + self.telco
            self.telcoCharge = (enteredAmount / 100) * 0.75;
            self.elevyCharge = (enteredAmount / 100) * 1.50;
            self.totalCharge = self.telcoCharge + self.elevyCharge;
            self.amount = (enteredAmount / 100) * self.totalCharge;
            self.amountSent = enteredAmount + self.totalCharge;
            print("ELEVY CHARGES - \(self.elevyCharge)")
        case "VODAFONE":
            self.elevy = 1.5
            self.telco = 0.00
            self.total = self.elevy + self.telco
            self.telcoCharge = (enteredAmount / 100) * 0.00;
            self.elevyCharge = (enteredAmount / 100) * 1.50;
            self.totalCharge = self.telcoCharge + self.elevyCharge;
            self.amount = (enteredAmount / 100) * self.totalCharge;
            self.amountSent = enteredAmount + self.totalCharge;
            print("ELEVY CHARGES - \(self.elevyCharge)")
        case "AIRTEL/TIGO":
            self.elevy = 1.5
            self.telco = 0.75
            self.total = self.elevy + self.telco
            self.telcoCharge = (enteredAmount / 100) * 0.75;
            self.elevyCharge = (enteredAmount / 100) * 1.50;
            self.totalCharge = self.telcoCharge + self.elevyCharge;
            self.amount = (enteredAmount / 100) * self.totalCharge;
            self.amountSent = enteredAmount + self.totalCharge;
            print("ELEVY CHARGES - \(self.elevyCharge)")
        default:
            print("default")
        }
        
        let elevy = Elevy(amount: self.amount, telcoCharges: self.telcoCharge, elevyCharges: self.elevyCharge, totalCharges: self.totalCharge, amountSent: self.amountSent, telco:self.telco, elevy: self.elevy, total: self.total)
        
        delegate?.didUpdateElevyCharges(elevy: elevy)
    }
}
