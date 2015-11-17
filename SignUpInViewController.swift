//
//  SignUpInViewController.swift
//  ParseTutorial
//
//  Created by Ian Bradbury on 10/02/2015.
//  Copyright (c) 2015 bizzi-body. All rights reserved.
//

import UIKit

class SignUpInViewController: UIViewController {
	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var message: UILabel!
	@IBOutlet weak var emailAddress: UITextField!
	@IBOutlet weak var password: UITextField!
	
	@IBAction func signUp(sender: AnyObject) {
		
		// Build the terms and conditions alert
		let alertController = UIAlertController(title: "Agree to terms and conditions",
			message: "Click I AGREE to signal that you agree to the End User Licence Agreement.",
			preferredStyle: UIAlertControllerStyle.Alert
		)
		alertController.addAction(UIAlertAction(title: "I AGREE",
			style: UIAlertActionStyle.Default,
			handler: { alertController in self.processSignUp()})
		)
		alertController.addAction(UIAlertAction(title: "I do NOT agree",
			style: UIAlertActionStyle.Default,
			handler: nil)
		)
		
		// Display alert
		self.presentViewController(alertController, animated: true, completion: nil)
	}
	
	@IBAction func signIn(sender: AnyObject) {
		
		activityIndicator.hidden = false
		activityIndicator.startAnimating()
		
		var userEmailAddress = emailAddress.text
		userEmailAddress = userEmailAddress!.lowercaseString
		
		var userPassword = password.text
		
		PFUser.logInWithUsernameInBackground(userEmailAddress!, password:userPassword!) {
			(user: PFUser?, error: NSError?) -> Void in
			if user != nil {
				dispatch_async(dispatch_get_main_queue()) {
					self.performSegueWithIdentifier("signInToNavigationTab", sender: self)
				}
			} else {
				self.activityIndicator.stopAnimating()
				
				if let message: AnyObject = error!.userInfo["error"] {
					self.message.text = "\(message)"
				}
			}
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		activityIndicator.hidden = true
		activityIndicator.hidesWhenStopped = true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	

	func processSignUp() {
		
		var userEmailAddress = emailAddress.text
		var userPassword = password.text
		
		// Ensure username is lowercase
		userEmailAddress = userEmailAddress!.lowercaseString
		
		// Add email address validation
		
		// Start activity indicator
		activityIndicator.hidden = false
		activityIndicator.startAnimating()
		
		// Create the user
		var user = PFUser()
		user.username = userEmailAddress
		user.password = userPassword
		user.email = userEmailAddress
		
		user.signUpInBackgroundWithBlock {
			(succeeded: Bool, error: NSError?) -> Void in
			if error == nil {
                // create user profile
				self.createUserProfile(userEmailAddress!)
				dispatch_async(dispatch_get_main_queue()) {
					self.performSegueWithIdentifier("signInToNavigationTab", sender: self)
				}
				
			} else {
				
				self.activityIndicator.stopAnimating()
			 
				if let message: AnyObject = error!.userInfo["error"] {
					self.message.text = "\(message)"
				}				
			}
		}
        
	}

    func createUserProfile(userEmailAddress: String) {
        
        var brewDevices: [String: Bool] = [
            "V60" : true,
            "Chemex" :false,
            "Aeropress" :false,
            "MokaPot" : false,
            "FrenchPress" : false,
            "AutoDrip" : false,
            "Espresso" : false,
            "Coldbrew": false
        ]
        
        var brewPrefs: [String: [String: Int]] = [
            "temp" : [
                "hot" : 0,
                "iced" : 0,
                "coldbrew" : 0
            ],
            "strength" : [
                "strong" : 0,
                "weak" : 0
            ],
            "roast" : [
                "light" : 0,
                "medium" : 0,
                "dark" : 0
            ],
            "extras" : [
                "dairy" : 0,
                "mocha" : 0,
                "vanilla" : 0,
                "none" : 0
            ]
        ]
        
        
        let profile = PFObject(className:"UserProfile")
        profile["username"] = userEmailAddress
        profile["brewPrefs"] = brewPrefs
        profile["brewDevices"] = brewDevices
        
        profile.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
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
