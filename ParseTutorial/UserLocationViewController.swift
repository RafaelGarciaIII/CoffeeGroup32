//
//  UserLocationViewController.swift
//  ParseTutorial
//
//  Created by Rafael Garcia on 11/15/15.
//  Copyright © 2015 bizzi-body. All rights reserved.
//

import UIKit

class UserLocationViewController: UIViewController {
    
           var manager:OneShotLocationManager?
    @IBOutlet weak var LAT: UILabel!
    @IBOutlet weak var LON: UILabel!
    @IBOutlet weak var homeLat: UILabel!
    @IBOutlet weak var homeLon: UILabel!

    @IBAction func saveLocation(sender: AnyObject) {
        
        let formatter = NSNumberFormatter();
        formatter.minimumFractionDigits = 1;
        formatter.maximumFractionDigits = 5;
        
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
                    
                    
                    self.manager = OneShotLocationManager()
                    self.manager!.fetchWithCompletion {location, error in
                        // fetch location or an error
                        if let loc = location {
                            self.LAT.text = formatter.stringFromNumber((location?.coordinate.latitude)!)
                            self.LON.text = formatter.stringFromNumber((location?.coordinate.longitude)!)
                            //sets home when pressed
                            self.homeLat.text = formatter.stringFromNumber((location?.coordinate.latitude)!)
                            self.homeLon.text = formatter.stringFromNumber((location?.coordinate.longitude)!)
                            
                            var location: [String: Double] = [
                                "lat" : (location?.coordinate.latitude)!,
                                "lon" : (location?.coordinate.longitude)!
                            ]
                            
                            object["homeLocation"] = location;
                            object.saveInBackground();
                            print("saved loc");
                            
                        } else if let err = error {
                            print(err.localizedDescription)
                        }
                        self.manager = nil
                    }
                    
                    
                    // << POPULATE THE CHECKBOXES HERE >>
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = NSNumberFormatter();
        formatter.minimumFractionDigits = 1;
        formatter.maximumFractionDigits = 5;
        
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
                        
                        self.manager = OneShotLocationManager()
                        self.manager!.fetchWithCompletion {location, error in
                            // fetch location or an error
                            if let loc = location {
                                self.LAT.text = formatter.stringFromNumber((location?.coordinate.latitude)!)
                                self.LON.text = formatter.stringFromNumber((location?.coordinate.longitude)!)

                        var locationHolder = object["homeLocation"] as! Dictionary<String, Double>
                        self.homeLat.text = formatter.stringFromNumber(locationHolder["lat"]!)
                        self.homeLon.text = formatter.stringFromNumber(locationHolder["lon"]!)
                            }}
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
