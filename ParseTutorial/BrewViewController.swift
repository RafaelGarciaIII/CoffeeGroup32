//
//  BrewViewController.swift
//  ParseTutorial
//
//  Created by Andrew Marshall on 11/15/15.
//  Copyright © 2015 bizzi-body. All rights reserved.
//

import UIKit


class BrewViewController: UIViewController{
    var manager:OneShotLocationManager?
    @IBOutlet weak var strengthSelect: UISegmentedControl!
    @IBOutlet weak var tempSelect: UISegmentedControl!
    @IBOutlet weak var roastSelect: UISegmentedControl!
    @IBOutlet weak var extraSelect: UISegmentedControl!
    @IBOutlet weak var deviceLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    

    
         var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNewBrewData()

        
    }
    
    @IBAction func likeClick(sender: AnyObject) {
        var brew = [String:String]()
        
        //roast
        if(self.roastSelect.selectedSegmentIndex == 0)
        {
            brew["roast"] = "light";
        }
        else if(self.roastSelect.selectedSegmentIndex == 1)
        {
            brew["roast"] = "medium";
        }
        else if(self.roastSelect.selectedSegmentIndex == 2)
        {
            brew["roast"] = "dark";
        }
        
        //strength
        if(self.strengthSelect.selectedSegmentIndex == 0)
        {
            brew["strength"] = "weak";
        }
        else if(self.strengthSelect.selectedSegmentIndex == 1)
        {
            brew["strength"] = "strong";
        }
        
        //temp
        if(self.tempSelect.selectedSegmentIndex == 0)
        {
            brew["temp"] = "hot";
        }
        else if(self.tempSelect.selectedSegmentIndex == 1)
        {
            brew["temp"] = "iced";
        }
        else if(self.tempSelect.selectedSegmentIndex == 2)
        {
            brew["temp"] = "coldbrew";
        }
        
        //extras
        if(self.extraSelect.selectedSegmentIndex == 0)
        {
            brew["extras"] = "none";
        }
        else if(self.extraSelect.selectedSegmentIndex == 1)
        {
            brew["extras"] = "dairy";
        }
        else if(self.extraSelect.selectedSegmentIndex == 2)
        {
            brew["extras"] = "mocha";
        }
        else if(self.extraSelect.selectedSegmentIndex == 3)
        {
            brew["extras"] = "vanilla";
        }
        
        saveBrewDataLike(brew)
   
        
    }
    
    @IBAction func dislikeClick(sender: AnyObject) {
        var brew = [String:String]()
        
        //roast
        if(self.roastSelect.selectedSegmentIndex == 0)
        {
            brew["roast"] = "light";
        }
        else if(self.roastSelect.selectedSegmentIndex == 1)
        {
            brew["roast"] = "medium";
        }
        else if(self.roastSelect.selectedSegmentIndex == 2)
        {
            brew["roast"] = "dark";
        }
        
        //strength
        if(self.strengthSelect.selectedSegmentIndex == 0)
        {
            brew["strength"] = "weak";
        }
        else if(self.strengthSelect.selectedSegmentIndex == 1)
        {
            brew["strength"] = "strong";
        }
        
        //temp
        if(self.tempSelect.selectedSegmentIndex == 0)
        {
            brew["temp"] = "hot";
        }
        else if(self.tempSelect.selectedSegmentIndex == 1)
        {
            brew["temp"] = "iced";
        }
        else if(self.tempSelect.selectedSegmentIndex == 2)
        {
            brew["temp"] = "coldbrew";
        }
        
        //extras
        if(self.extraSelect.selectedSegmentIndex == 0)
        {
            brew["extras"] = "none";
        }
        else if(self.extraSelect.selectedSegmentIndex == 1)
        {
            brew["extras"] = "dairy";
        }
        else if(self.extraSelect.selectedSegmentIndex == 2)
        {
            brew["extras"] = "mocha";
        }
        else if(self.extraSelect.selectedSegmentIndex == 3)
        {
            brew["extras"] = "vanilla";
        }
        
        print(brew)
        
        saveBrewDataDislike(brew)
    }
    
    
    
    @IBAction func signOut(sender: AnyObject) {

        
        PFUser.logOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func deviceFunction(device:String)
    {
        dispatch_async(dispatch_get_main_queue(),{
            self.deviceLabel.text=device})
        print("reached");
    }
    // TODO: Hook this function up with the gui elements
    func setNewBrewData(){
        
        
        
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
                    var brewDevices = object["brewDevices"] as! [String: Bool]
                    
                    // pick random brew device
                    var devices = [String]()
                    for (key, value) in brewDevices {
                        if (value) {
                            devices.append(key)
                        }
                    }
                    var device = devices[Int(arc4random_uniform(UInt32(devices.count)))]
                    
                    var brewPrefs = object["brewPrefs"] as! [String: [String: Int]]
                    getTemp({ (result) -> Void in
                        var brew = getBrew(result, brewPrefs: brewPrefs)
                        brew["device"] = device
                        print(brew)
                        // << POPULATE THE BREW ELEMENTS HERE >>
                        //temp
                        if(brew["temp"] == "hot")
                        {
                            self.tempSelect.selectedSegmentIndex = 0;
                        }
                        else if(brew["temp"] == "iced")
                        {
                            self.tempSelect.selectedSegmentIndex=1;
                        }
                        else if(brew["temp"] == "coldbrew")
                        {
                            self.tempSelect.selectedSegmentIndex=2;
                        }
                        //extras
                        if(brew["extras"] == "none")
                        {
                            self.extraSelect.selectedSegmentIndex = 0;
                        }
                        else if(brew["extras"] == "dairy")
                        {
                            self.extraSelect.selectedSegmentIndex = 1;
                        }
                        else if(brew["extras"] == "mocha")
                        {
                            self.extraSelect.selectedSegmentIndex = 2;
                        }
                        else if(brew["extras"] == "vanilla")
                        {
                            self.extraSelect.selectedSegmentIndex = 3;
                        }
                        //Strength
                        if(brew["strength"] == "weak")
                        {
                            self.strengthSelect.selectedSegmentIndex = 0;
                        }
                        else if(brew["strength"] == "strong")
                        {
                            self.strengthSelect.selectedSegmentIndex = 1;
                        }
                        //device
                        
                        self.deviceFunction(brew["device"] as String!)
                        
                        //roast 
                        if(brew["roast"] == "light")
                        {
                            self.roastSelect.selectedSegmentIndex = 0;
                        }
                        else if(brew["roast"] == "medium")
                        {
                            self.roastSelect.selectedSegmentIndex = 1;
                        }
                        else if(brew["roast"] == "dark")
                        {
                            self.roastSelect.selectedSegmentIndex = 2;
                        }
                        
                    })
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    
    func saveBrewDataLike(brew: [String: String]) {
        
        
        
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
                    
                    
                    
                    var brewPrefs = object["brewPrefs"] as! [String: [String: Int]]
                    
                    
                    
                    brewPrefs["roast"]![brew["roast"]!]!++
                    
                    brewPrefs["strength"]![brew["strength"]!]!++
                    
                    brewPrefs["extras"]![brew["extras"]!]!++
                    
                    brewPrefs["temp"]![brew["temp"]!]!++
                    
                    
                    
                    object["brewPrefs"] = brewPrefs
                    
                    
                    
                    object.saveInBackground();
                    
                }
                
            } else {
                
                // Log details of the failure
                
                print("Error: \(error!) \(error!.userInfo)")
                
            }
            
        }
        
        
        
        setNewBrewData()
        
    }
    
    
    
    func saveBrewDataDislike(brew: [String: String]) {
        
        
        
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
                    
                    
                    
                    var brewPrefs = object["brewPrefs"] as! [String: [String: Int]]
                    
                    
                    
                    brewPrefs["roast"]![brew["roast"]!]!--
                    
                    brewPrefs["strength"]![brew["strength"]!]!--
                    
                    brewPrefs["extras"]![brew["extras"]!]!--
                    
                    brewPrefs["temp"]![brew["temp"]!]!--
                    
                    
                    
                    object["brewPrefs"] = brewPrefs
                    
                    
                    
                    object.saveInBackground();
                    
                }
                
            } else {
                
                // Log details of the failure
                
                print("Error: \(error!) \(error!.userInfo)")
                
            }
            
        }
        
        
        
        setNewBrewData()
        
    }
}
