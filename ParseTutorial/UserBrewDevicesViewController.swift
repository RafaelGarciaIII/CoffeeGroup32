//
//  UserTableViewController.swift
//  ParseTutorial
//
//  Created by Rafael Garcia on 11/14/15.
//  Copyright © 2015 bizzi-body. All rights reserved.
//

import UIKit

class UserBrewDevicesController: UIViewController {

    @IBOutlet weak var V60Switch: UISwitch!
    @IBOutlet weak var ChemexSwitch: UISwitch!
    @IBOutlet weak var EspressoSwitch: UISwitch!
    @IBOutlet weak var FrenchPressSwitch: UISwitch!
    @IBOutlet weak var AeropressSwitch: UISwitch!
    @IBOutlet weak var MokaPotSwitch: UISwitch!
    @IBOutlet weak var AutoDripSwitch: UISwitch!
    @IBOutlet weak var ColdBrewSwitch: UISwitch!
    
    
    @IBAction func saveBrefs(sender: AnyObject) {
        
        let userEmail = PFUser.currentUser()!["username"] as? String
        let query = PFQuery(className:"UserProfile")
        query.whereKey("username", equalTo:(userEmail)!)
        
        //query.findObjectsInBackgroundWithBlock {
        query.getFirstObjectInBackgroundWithBlock {
            (object, error) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved UserProfile object!")
                // Do something with the found objects
                if let object = object {
                    var brewDevices = object["brewDevices"] as! Dictionary<String, Bool>
                    //updated v60
                    if(self.V60Switch.on == false){
                    brewDevices["V60"] = false}
                    else{
                        brewDevices["V60"] = true;}
                    //update chemex
                    if(self.ChemexSwitch.on == false){
                        brewDevices["Chemex"] = false}
                    else{
                        brewDevices["Chemex"] = true;}
                    //updated espresso
                    if(self.EspressoSwitch.on == false){
                        brewDevices["Espresso"] = false}
                    else{
                        brewDevices["Espresso"] = true;}
                    //update french press
                    if(self.FrenchPressSwitch.on == false){
                        brewDevices["FrenchPress"] = false}
                    else{
                        brewDevices["FrenchPress"] = true;}
                    //update aeropress
                    if(self.AeropressSwitch.on == false){
                        brewDevices["Aeropress"] = false}
                    else{
                        brewDevices["Aeropress"] = true;}
                    //update moka pot
                    if(self.MokaPotSwitch.on == false){
                        brewDevices["MokaPot"] = false}
                    else{
                        brewDevices["MokaPot"] = true;}
                    //update autoDrip
                    if(self.AutoDripSwitch.on == false){
                        brewDevices["AutoDrip"] = false}
                    else{
                        brewDevices["AutoDrip"] = true;}
                    //updated cold brew
                    if(self.ColdBrewSwitch.on == false){
                        brewDevices["Coldbrew"] = false}
                    else{
                        brewDevices["Coldbrew"] = true;}
                    
                    // << POPULATE THE CHECKBOXES HERE >>
                    print("I REACHED THIS")
                    object["brewDevices"] = brewDevices;
                    object.saveInBackground();
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userEmail = PFUser.currentUser()!["username"] as? String
        
        let query = PFQuery(className:"UserProfile")
        query.whereKey("username", equalTo:(userEmail)!)
        
        //query.findObjectsInBackgroundWithBlock {
        query.getFirstObjectInBackgroundWithBlock {
            (object, error) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved UserProfile object!")
                // Do something with the found objects
                if let object = object {
                    var brewDevices = object["brewDevices"] as! Dictionary<String, Bool>
                    if(brewDevices["V60"] == false){
                        self.V60Switch.on = false;}
                    else{
                        self.V60Switch.on=true;}
                    if(brewDevices["Aeropress"] == false){
                        self.AeropressSwitch.on = false;}
                    else{
                        self.AeropressSwitch.on=true;}
                    if(brewDevices["AutoDrip"] == false){
                        self.AutoDripSwitch.on = false;}
                    else{
                        self.AutoDripSwitch.on=true;}
                    if(brewDevices["Chemex"] == false){
                        self.ChemexSwitch.on = false;}
                    else{
                        self.ChemexSwitch.on=true;}
                    if(brewDevices["Coldbrew"] == false){
                        self.ColdBrewSwitch.on = false;}
                    else{
                        self.ColdBrewSwitch.on=true;}
                    if(brewDevices["FrenchPress"] == false){
                        self.FrenchPressSwitch.on = false;}
                    else{
                        self.FrenchPressSwitch.on=true;}
                    if(brewDevices["MokaPot"] == false){
                        self.MokaPotSwitch.on = false;}
                    else{
                        self.MokaPotSwitch.on=true;}
                    if(brewDevices["Espresso"] == false){
                        self.EspressoSwitch.on = false;}
                    else{
                        self.EspressoSwitch.on=true;}
                    
                    // << POPULATE THE CHECKBOXES HERE >>
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    @IBAction func add(sender: AnyObject) {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("TableViewToDetailBrewView", sender: self)
        }
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
