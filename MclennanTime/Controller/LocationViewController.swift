//
//  ViewController.swift
//  MclennanTime
//
//  Created by Alex Ference on 2020-02-01.
//  Copyright © 2020 Alex Ference. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class LocationViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    //@IBOutlet weak var latLabel: UILabel!
    //@IBOutlet weak var longLabel: UILabel!
    //@IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var locationSwitch: UISwitch!
    
    var isInLibrary = false
    
    var lastFalseTime = Date().timeIntervalSince1970
    
    let db = Firestore.firestore()
    
    var counter = 0
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        navigationItem.setHidesBackButton(true, animated: true);
        
        lastFalseTime = Date().timeIntervalSince1970
        
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.setHidesBackButton(true, animated: true)
        
        if let uid = Auth.auth().currentUser?.uid {
            let docRef = db.collection(K.usersCollection).document(uid)
            docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data()
                            if let name = dataDescription?[K.FStore.nameField] {
                                self.welcomeLabel.text = "Welcome \(name)"
                            }
                        } else {
                            print("Document does not exist")
                        }
            }
        }
        
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
            //latLabel.text = String(lat)
            //longLabel.text = String(long)
            
            //validate if it is in desired area here
            if ValidationManager.isInLibrary(latitude: lat, longitude: long) == true {
                if isInLibrary == false {
                    print("you have entered the library")
                    lastFalseTime = Date().timeIntervalSince1970
                    isInLibrary = true
                }
                else {
                    print("problem with isInLibrary")
                }
            }
            else {
                if isInLibrary == true {
                    print("you have left the library")
                    var totalTime = Date().timeIntervalSince1970 - lastFalseTime
                    print(totalTime)
                    isInLibrary = false
                    
                }
                
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

