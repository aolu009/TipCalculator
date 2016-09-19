//
//  SettingsPage.swift
//  TipCalculator
//
//  Created by Lu Ao on 7/26/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit

class SettingsPage: UIViewController {

    
    @IBOutlet weak var tipTier1: UITextField!
    @IBOutlet weak var tipTier2: UITextField!
    @IBOutlet weak var tipTier3: UITextField!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    
    var tipPercentages = [Double]()
    var themeGreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tipPercentages)
        tipTier1.text = String(tipPercentages[0]*100)
        tipTier2.text = String(tipPercentages[1]*100)
        tipTier3.text = String(tipPercentages[2]*100)
        tipTier1.layer.borderColor = UIColor.blue.cgColor
        tipTier1.layer.borderWidth = CGFloat(1.0)
        tipTier2.layer.borderColor = UIColor.blue.cgColor
        tipTier2.layer.borderWidth = CGFloat(1.0)
        tipTier3.layer.borderColor = UIColor.blue.cgColor
        tipTier3.layer.borderWidth = CGFloat(1.0)
        themeSwitch.isOn = defaults.bool(forKey: "themeSwitch")
        themeGreen = defaults.bool(forKey: "themeGreen")
    }
    
    
    let defaults = UserDefaults.standard
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func changeTier1(_ sender: AnyObject) {
        let newTip: Double = (tipTier1.text! as NSString).doubleValue/100
        tipPercentages[0] = newTip
    }
    
    @IBAction func changeTier2(_ sender: AnyObject) {
        let newTip: Double = (tipTier2.text! as NSString).doubleValue
        tipPercentages[1] = newTip/100
    }
    
    @IBAction func changeTier3(_ sender: AnyObject) {
        let newTip: Double = (tipTier3.text! as NSString).doubleValue
        tipPercentages[2] = newTip/100
    
    }
    
    @IBAction func greenTheme(_ sender: UISwitch) {
        if themeSwitch.isOn == true{
            themeGreen = true
            defaults.set(themeSwitch.isOn, forKey: "themeSwitch")
            defaults.set(themeGreen, forKey: "themeGreen")
            defaults.synchronize()
        }
        if themeSwitch.isOn == false{
            themeGreen = false
            defaults.set(themeSwitch.isOn, forKey: "themeSwitch")
            defaults.set(themeGreen, forKey: "themeGreen")
            defaults.synchronize()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "Back") {
            
            let navController = segue.destination as! UINavigationController
            let destinationVC = navController.topViewController as! MainPage
            //let destinationVC = segue.destination as! MainPage
            
            destinationVC.defaults.set(tipPercentages[0], forKey: "tipPercentages0")
            destinationVC.defaults.set(tipPercentages[1], forKey: "tipPercentages1")
            destinationVC.defaults.set(tipPercentages[2], forKey: "tipPercentages2")
            destinationVC.themeGreen = themeGreen
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.performSegue(withIdentifier: "Back" , sender: self)
        
            }
}
