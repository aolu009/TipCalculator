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
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        let locale = NSLocale.currentLocale()
        let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol) as? String
        print("",currencySymbol!)
        tipLabel.text = currencySymbol!+"0.00"
        totalLabek.text = currencySymbol!+"0.00"
        billField.becomeFirstResponder()
        tipPercentages[0] = defaults.doubleForKey("tipPercentages0")
        tipPercentages[1] = defaults.doubleForKey("tipPercentages1")
        tipPercentages[2] = defaults.doubleForKey("tipPercentages2")
        tipControl.setTitle(String(tipPercentages[0]*100)+"%", forSegmentAtIndex: 0)
        tipControl.setTitle(String(tipPercentages[1]*100)+"%", forSegmentAtIndex: 1)
        tipControl.setTitle(String(tipPercentages[2]*100)+"%", forSegmentAtIndex: 2)
        billField.layer.borderColor = UIColor.blueColor().CGColor
        taxAmount.layer.borderWidth = CGFloat(1.0)
        taxAmount.layer.borderColor = UIColor.blueColor().CGColor
        billField.layer.borderWidth = CGFloat(1.0)
        totalLabek.text = defaults.stringForKey("totalLabek")
        billField.text = defaults.stringForKey("billField")
        tipLabel.text = defaults.stringForKey("tipLabel")
        taxcalculated.text = defaults.stringForKey("taxcalculated")
        print(tipPercentages)
                taxAmount.text = defaults.stringForKey("taxAmount")
        themeGreen = defaults.boolForKey("themeGreen")
        self.view.backgroundColor = themeGreen == true ? UIColor.greenColor() : UIColor.whiteColor()
    }
    /*
    override func viewWillDisappear(animated: Bool) {
        defaults.setDouble(tipPercentages[0], forKey: "tipPercentages0")
        defaults.setDouble(tipPercentages[1], forKey: "tipPercentages1")
        defaults.setDouble(tipPercentages[2], forKey: "tipPercentages2")
    }
    */
    var tipPercentages = [0.15,0.18,0.2]
    let defaults = NSUserDefaults.standardUserDefaults()
    var themeGreen: Bool = false
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        //let locale = NSLocale.currentLocale()
        //let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol) as? String
        //print("",currencySymbol!)
        let tax: Double = (taxAmount.text! as NSString).doubleValue
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        print(tipControl.selectedSegmentIndex)
        let bill: Double = (billField.text! as NSString).doubleValue
        
        let tip: Double = bill * tipPercentage
        //billField.text = currencySymbol! + billField.text!
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 2
        totalLabek.text = formatter.stringFromNumber(tip + bill+tax)
        tipLabel.text = formatter.stringFromNumber(tip)
        print(bill)
        if bill != 0.0 {
            taxcalculated.text = String(format: "%.2f",100*tax/bill) + "%"
        }
        else{
            taxcalculated.text = "0.00%"
        }
        //defaults.setObject(tipPercentages, forKey: "tipPercentages")
        defaults.setObject(totalLabek.text, forKey: "totalLabek")
        defaults.setObject(billField.text, forKey: "billField")
        defaults.setObject(tipLabel.text, forKey: "tipLabel")
        defaults.setObject(taxcalculated.text, forKey: "taxcalculated")
        defaults.setObject(taxAmount.text, forKey: "taxAmount")
        defaults.setBool(themeGreen, forKey: "themeGreen")
        defaults.synchronize()
        
    }
    
    @IBAction func settingPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("Settings" , sender: tipPercentages)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "Settings") {
            //get a reference to the destination view controller
            let destinationVC = segue.destinationViewController as! SettingsPage
            destinationVC.tipPercentages = tipPercentages
            
        }
    }

}

