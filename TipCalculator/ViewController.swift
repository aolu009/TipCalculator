//
//  ViewController.swift
//  TipCalculator
//
//  Created by Lu Ao on 7/24/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class MainPage: UIViewController {

    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabek: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var taxAmount: UITextField!
    @IBOutlet weak var taxcalculated: UILabel!
    
    @IBOutlet weak var settingButton: UIButton!
    
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        settingButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        let locale = Locale.current
        let currencySymbol = (locale as NSLocale).object(forKey: NSLocale.Key.currencySymbol) as? String
        tipLabel.text = currencySymbol!+"0.00"
        totalLabek.text = currencySymbol!+"0.00"
        billField.becomeFirstResponder()
        
        tipPercentages[0] = defaults.double(forKey: "tipPercentages0")
        tipPercentages[1] = defaults.double(forKey: "tipPercentages1")
        tipPercentages[2] = defaults.double(forKey: "tipPercentages2")
        tipControl.setTitle(String(tipPercentages[0]*100)+"%", forSegmentAt: 0)
        tipControl.setTitle(String(tipPercentages[1]*100)+"%", forSegmentAt: 1)
        tipControl.setTitle(String(tipPercentages[2]*100)+"%", forSegmentAt: 2)
        
        billField.layer.borderColor = UIColor.blue.cgColor
        taxAmount.layer.borderWidth = CGFloat(1.0)
        taxAmount.layer.borderColor = UIColor.blue.cgColor
        billField.layer.borderWidth = CGFloat(1.0)
        totalLabek.text = defaults.string(forKey: "totalLabek")
        billField.text = defaults.string(forKey: "billField")
        tipLabel.text = defaults.string(forKey: "tipLabel")
        taxcalculated.text = defaults.string(forKey: "taxcalculated")
                taxAmount.text = defaults.string(forKey: "taxAmount")
        themeGreen = defaults.bool(forKey: "themeGreen")
        self.view.backgroundColor = themeGreen == true ? UIColor.green : UIColor.white
    }
    
    var tipPercentages = [0.15,0.18,0.2]
    let defaults = UserDefaults.standard
    var themeGreen: Bool = false
    
    @IBAction func onEditingChanged(_ sender: AnyObject) {
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.maximumIntegerDigits = 6
        let billText = billField.text!.replacingOccurrences(of: formatter.currencySymbol, with: "").replacingOccurrences(of: formatter.groupingSeparator, with: "").replacingOccurrences(of: formatter.decimalSeparator, with: "")
        let taxText = taxAmount.text!.replacingOccurrences(of: formatter.currencySymbol, with: "").replacingOccurrences(of: formatter.groupingSeparator, with: "").replacingOccurrences(of: formatter.decimalSeparator, with: "")
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let bill: Double = (billText as NSString).doubleValue/100
        let taxes: Double = (taxText as NSString).doubleValue/100
        
        let tip: Double = bill * tipPercentage
        
        
        taxAmount.text = formatter.string(from: taxes as NSNumber)
        billField.text = formatter.string(from: bill as NSNumber)
        totalLabek.text = formatter.string(from:(tip + bill + taxes) as NSNumber)
        
        tipLabel.text = formatter.string(from: tip as NSNumber)
        if bill != 0.0 {
            taxcalculated.text = String(format: "%.2f",100*taxes/bill) + "%"
        }
        else{
            taxcalculated.text = "0.00%"
        }
        defaults.set(totalLabek.text, forKey: "totalLabek")
        defaults.set(billField.text, forKey: "billField")
        defaults.set(tipLabel.text, forKey: "tipLabel")
        defaults.set(taxcalculated.text, forKey: "taxcalculated")
        defaults.set(taxAmount.text, forKey: "taxAmount")
        defaults.set(themeGreen, forKey: "themeGreen")
        defaults.synchronize()
        
    }
    
    @IBAction func settingPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "Settings" , sender: tipPercentages)
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "Settings") {
            //get a reference to the destination view controller
            let destinationVC = segue.destination as! SettingsPage
            destinationVC.tipPercentages = tipPercentages
            
        }
    }

}

