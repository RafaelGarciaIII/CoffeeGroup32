//
//  LocateViewController.swift
//  ParseTutorial
//
//  Created by Rafael Garcia on 11/14/15.
//  Copyright © 2015 bizzi-body. All rights reserved.
//

import UIKit
import MapKit

class LocateViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var manager:OneShotLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var initialLocation = CLLocation(latitude: 37.7836, longitude: -122.408)
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                initialLocation = CLLocation(latitude:(location?.coordinate.latitude)!, longitude:  (location?.coordinate.longitude)!)
                self.centerMapOnLocation(initialLocation);
            } else if let err = error {
                
            }
            self.manager = nil
        }
        
        
        
        
        //centerMapOnLocation(initialLocation)
        
        // Do any additional setup after loading the view.
    }
    
    let regionRadius: CLLocationDistance = 1500
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
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
