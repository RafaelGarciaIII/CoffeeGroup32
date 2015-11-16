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

    @IBAction func saveLocation(sender: AnyObject) {
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
                            self.LAT.text = location?.coordinate.latitude.description;
                            self.LON.text = location?.coordinate.longitude.description;
                            var location: [String: Double] = [
                                "lat" : (location?.coordinate.latitude)!,
                                "lon" : (location?.coordinate.longitude)!
                            ]
                            object["homeLocation"] = location;
                            object.saveInBackground();
                            
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
                                //object["homeLocation"] = location?.coordinate as! AnyObject;
                               // self.LAT.text = location?.coordinate.latitude.description;
                               // self.LON.text = location?.coordinate.longitude.description;
                                
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
