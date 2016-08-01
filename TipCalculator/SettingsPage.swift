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
    //var tipControl: UISegmentedControl!
    var themeGreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tipPercentages)
        //print(tipControl.titleForSegmentAtIndex(0))
        tipTier1.text = String(tipPercentages[0]*100)
        tipTier2.text = String(tipPercentages[1]*100)
        tipTier3.text = String(tipPercentages[2]*100)
        tipTier1.layer.borderColor = UIColor.blueColor().CGColor
        tipTier1.layer.borderWidth = CGFloat(1.0)
        tipTier2.layer.borderColor = UIColor.blueColor().CGColor
        tipTier2.layer.borderWidth = CGFloat(1.0)
        tipTier3.layer.borderColor = UIColor.blueColor().CGColor
        tipTier3.layer.borderWidth = CGFloat(1.0)
        themeSwitch.on = defaults.boolForKey("themeSwitch")
        themeGreen = defaults.boolForKey("themeGreen")
    }
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func changeTier1(sender: AnyObject) {
        let newTip: Double = (tipTier1.text! as NSString).doubleValue/100
        tipPercentages[0] = newTip
    }
    
    @IBAction func changeTier2(sender: AnyObject) {
        let newTip: Double = (tipTier2.text! as NSString).doubleValue
        tipPercentages[1] = newTip/100
    }
    
    @IBAction func changeTier3(sender: AnyObject) {
        let newTip: Double = (tipTier3.text! as NSString).doubleValue
        tipPercentages[2] = newTip/100
    
    }
    
    @IBAction func greenTheme(sender: UISwitch) {
        if themeSwitch.on == true{
            themeGreen = true
            defaults.setBool(themeSwitch.on, forKey: "themeSwitch")
            defaults.setBool(themeGreen, forKey: "themeGreen")
            defaults.synchronize()
        }
        if themeSwitch.on == false{
            themeGreen = false
            defaults.setBool(themeSwitch.on, forKey: "themeSwitch")
            defaults.setBool(themeGreen, forKey: "themeGreen")
            defaults.synchronize()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "Back") {
            
            let navController = segue.destinationViewController as! UINavigationController
            let destinationVC = navController.topViewController as! MainPage
            
            //destinationVC.tipPercentages = tipPercentages
            destinationVC.defaults.setDouble(tipPercentages[0], forKey: "tipPercentages0")
            destinationVC.defaults.setDouble(tipPercentages[1], forKey: "tipPercentages1")
            destinationVC.defaults.setDouble(tipPercentages[2], forKey: "tipPercentages2")
            //destinationVC.tipControl = tipControl
            destinationVC.themeGreen = themeGreen
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.performSegueWithIdentifier("Back" , sender: tipPercentages)
    }
}
