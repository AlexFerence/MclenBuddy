//
//  ViewController.swift
//  MclennanTime
//
//  Created by Alex Ference on 2020-02-01.
//  Copyright © 2020 Alex Ference. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var locationSwitch: UISwitch!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        
    }
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        return manager
    }()
    
    @IBAction func LocationSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            locationManager.startUpdatingLocation()
        }
        else {
            locationManager.stopUpdatingLocation()
        }
    }
}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            var lat = loc.coordinate.latitude
            var long = loc.coordinate.longitude
            print(lat, long)
            latLabel.text = String(lat)
            longLabel.text = String(long)
            
            //validate if it is in desired area here
            if ValidationManager.isInLibrary(latitude: lat, longitude: long) == true {
                counter = counter + 1
                counterLabel.text = String(counter)
            }
            
        }
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        if UIApplication.shared.applicationState == .active {
            
        }
        else {
            print("app is in the bacground, location tracking is:\(mostRecentLocation)")
        }
    }
}

