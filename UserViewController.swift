//
//  UserViewController.swift
//  ParseTutorial
//
//  Created by Rafael Garcia on 11/14/15.
//  Copyright © 2015 bizzi-body. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var manager:OneShotLocationManager?


    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let formatter = NSNumberFormatter();
        formatter.minimumFractionDigits = 1;
        formatter.maximumFractionDigits = 5;
        
        
        // ** LOAD USER PROFILE
        // Load the users profile so that we can display their brew devices
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
                            
                            
                            self.latLabel.text = formatter.stringFromNumber((location?.coordinate.latitude)!);
                            self.lonLabel.text = formatter.stringFromNumber((location?.coordinate.longitude)!);
                            
                        } else if let err = error {
                            print(err.localizedDescription)
                        }
                        self.manager = nil
                    }
        // ** END LOAD USER PROFILE
        
                    //time ?
                    let date = NSDate()
                    let formatter = NSDateFormatter()
                    formatter.timeStyle = .ShortStyle
                    self.timeLabel.text=formatter.stringFromDate(date)
                    
                    
        self.usernameLabel.text = userEmail;
        
        
        
                }}}
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Sign the user out
    @IBAction func signOut(sender: AnyObject) {
        
        PFUser.logOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController")
        self.presentViewController(vc, animated: true, completion: nil)
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
