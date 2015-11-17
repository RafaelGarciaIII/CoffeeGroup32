//
//  BrewViewController.swift
//  ParseTutorial
//
//  Created by Andrew Marshall on 11/15/15.
//  Copyright © 2015 bizzi-body. All rights reserved.
//

import UIKit


class BrewViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    var manager:OneShotLocationManager?
    @IBOutlet weak var devicePicker: UIPickerView!
    @IBOutlet weak var strengthSelect: UISegmentedControl!
    @IBOutlet weak var tempSelect: UISegmentedControl!
    @IBOutlet weak var roastSelect: UISegmentedControl!
    @IBOutlet weak var extraSelect: UISegmentedControl!
    
         var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTemp({ (result) -> Void in
            
            print(result)
            
        })
        
        getCity({ (result) -> Void in
            
            print(result)
            
        })
        
        
        let userEmail = PFUser.currentUser()!["username"] as? String
        
        let query = PFQuery(className:"UserProfile")
        query.whereKey("username", equalTo:(userEmail)!)
        
   
        self.devicePicker.delegate = self
        self.devicePicker.dataSource = self
        self.pickerData += ["this should show"]
        self.pickerData += ["this should show three"]
        
        //query.findObjectsInBackgroundWithBlock {
        query.getFirstObjectInBackgroundWithBlock {
            (object, error) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved UserProfile object!")
                // Do something with the found objects
                if let object = object {
                    var brewDevices = object["brewDevices"] as! Dictionary<String, Bool>
                    if(brewDevices["V60"] == false){}
                    else{
                        self.pickerData += ["V60"];
                        print("Was here");
                    }
                    self.pickerData += ["fucl"]
                    
                    // << POPULATE THE CHECKBOXES HERE >>
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        self.pickerData += ["useless"]

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
