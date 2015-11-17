//
//  util.swift
//  ParseTutorial
//
//  Created by Andrew Marshall on 11/15/15.
//  Copyright © 2015 bizzi-body. All rights reserved.
//

import Foundation
import UIKit


func getTemp(completion: (result: Int) -> Void){
    
    var manager:OneShotLocationManager?
    // get lat and lon
    var coords = [String: Double]()
    manager = OneShotLocationManager()
    manager!.fetchWithCompletion {location, error in
        // fetch location or an error
        if let loc = location {
            coords = [
                "lat" : (location?.coordinate.latitude)!,
                "lon" : (location?.coordinate.longitude)!
            ]
            let lat = coords["lat"]?.description
            let lon = coords["lon"]?.description
            
            let url = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20geo.placefinder%20WHERE%20text%3D%22"
                + lat! + "%2C" + lon! + "%22%20and%20gflags%3D%22R%22&format=json"
            
            let nsurl = NSURL(string: url)
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(nsurl!) {(data, response, error) in
                var strResult = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
                
                let json = convertStringToDictionary(strResult)
                let woeid:String = json!.objectForKey("query")!.objectForKey("results")!.objectForKey("Result")!.objectForKey("woeid") as! String

                let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D"
                    + woeid + "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
                let nsurl = NSURL(string: url)
                let task = NSURLSession.sharedSession().dataTaskWithURL(nsurl!) {(data, response, error) in
                    var strResult = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
                    let json = convertStringToDictionary(strResult)
                    let tempStr:String = json!.objectForKey("query")!.objectForKey("results")!.objectForKey("channel")!.objectForKey("item")!.objectForKey("condition")!.objectForKey("temp") as! String
                    
                    /////////
                    completion(result: Int(tempStr)!)
                    /////////
                }
                task.resume()
            }
            task.resume()
            
        } else if let err = error {
            print(err.localizedDescription)
        }
        manager = nil
        
    }
    
}


func getCity(completion: (result: String) -> Void){
    
    var manager:OneShotLocationManager?
    // get lat and lon
    var coords = [String: Double]()
    manager = OneShotLocationManager()
    manager!.fetchWithCompletion {location, error in
        // fetch location or an error
        if let loc = location {
            coords = [
                "lat" : (location?.coordinate.latitude)!,
                "lon" : (location?.coordinate.longitude)!
            ]
            let lat = coords["lat"]?.description
            let lon = coords["lon"]?.description
            
            let url = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20geo.placefinder%20WHERE%20text%3D%22"
                + lat! + "%2C" + lon! + "%22%20and%20gflags%3D%22R%22&format=json"
            
            let nsurl = NSURL(string: url)
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(nsurl!) {(data, response, error) in
                var strResult = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
                
                let json = convertStringToDictionary(strResult)
                let city:String = json!.objectForKey("query")!.objectForKey("results")!.objectForKey("Result")!.objectForKey("city") as! String
                
                completion(result: city)
            }
            task.resume()
            
        } else if let err = error {
            print(err.localizedDescription)
        }
        manager = nil
        
    }
    
}




func convertStringToDictionary(text: String) -> NSDictionary? {
    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
            return json
        } catch {
            print("Something went wrong")
        }
    }
    return nil
}








