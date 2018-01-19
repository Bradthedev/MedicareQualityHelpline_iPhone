//
//  ViewController.swift
//  Medicare Quality Helpline
//
//  Created by Brad Collins on 1/16/18.
//  Copyright © 2018 livanta. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate  {
    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes. s
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let LOCATION_RADIUS_CONSTANT = 0.0002;
        
        let currentLat = userLocation.coordinate.latitude
        let currentLng = userLocation.coordinate.longitude
        
        let maxLat = currentLat + LOCATION_RADIUS_CONSTANT
        let minLat = currentLat - LOCATION_RADIUS_CONSTANT
        
        let maxLng = currentLng + LOCATION_RADIUS_CONSTANT
        let minLng = currentLng - LOCATION_RADIUS_CONSTANT
        
        if(currentLat > minLat && currentLat < maxLat && currentLng > minLng && currentLng < maxLng){
            let alert = UIAlertController(title: "Quality of care concern?", message: "Are you on Medicare and concerned about the quality of care you are received at Livanta, would you like to call the quality Helpline?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HospitalLocations")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let hospitalLat:Double = data.value(forKey: "hospital_lat") as! Double;
                let hospitalLng:Double = data.value(forKey: "hospital_lng") as! Double;

                if(hospitalLat > minLat && hospitalLat < maxLat && hospitalLng > minLng && hospitalLng < maxLng){
                    let alert = UIAlertController(title: "Quality of care concern?", message: "Are you on Medicare and concerned about the quality of care you are received at Livanta, would you like to call the quality Helpline?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        } catch {
            
            print("Failed")
        }   
        
        //where the logic goes for stuff)
        
        manager.stopUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    @IBAction func area5(_ sender: UIButton) {
    }
    
    @IBAction func area1(_ sender: UIButton) {
    }
    
    @IBAction func keypro(_ sender: Any) {
    }
    
    //use this to change the text of the call button to "Click here to go to KEYPRO"
    @IBOutlet weak var keyproChangeText: UIButton!
}
