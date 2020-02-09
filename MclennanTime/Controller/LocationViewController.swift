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
    @IBOutlet weak var dayCounterLabel: UILabel!
    @IBOutlet weak var weekCounterLabel: UILabel!
    @IBOutlet weak var totalCounterLabel: UILabel!
    
    @IBOutlet weak var locationSwitch: UISwitch!
    
    var isInLibrary = false
    
    var lastFalseTime = Date().timeIntervalSince1970
    
    let db = Firestore.firestore()
    
    var counter = 0
    
    var dailyCounter = 0.0
    var weeklyCounter = 0.0
    var totalCounter = 0.0
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        navigationItem.setHidesBackButton(true, animated: true);
        
        lastFalseTime = Date().timeIntervalSince1970
        
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.setHidesBackButton(true, animated: true)
        
        if let uid = Auth.auth().currentUser?.uid {
            let docRef = db.collection(K.FStore.usersCollection).document(uid)
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
        print("starting to update location")
        locationManager.startUpdatingLocation()
        if let user = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.timeCollection).whereField(K.FStore.emailField, isEqualTo: user).addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.dailyCounter = 0.0
                    self.weeklyCounter = 0.0
                    self.totalCounter = 0.0
                    for document in querySnapshot!.documents {
                        //print(document.data()[K.FStore.emailField])
                        if let emailData = document.data()[K.FStore.emailField] as? String, let timeUpdated = document.data()[K.FStore.timeUpdated] as? Double, let timeField = document.data()[K.FStore.timeField] as? Double {
                            //print(timeUpdated)
                            if Date().timeIntervalSince1970 - timeUpdated < 86400 {
                                self.dailyCounter = self.dailyCounter + timeField
                            }
                            if Date().timeIntervalSince1970 - timeUpdated < 604800 {
                                self.weeklyCounter = self.weeklyCounter + timeField
                            }
                            self.totalCounter = self.totalCounter + timeField
                            
                        }
                    }
                    //after the loop has counted everything set the labels
                    self.dayCounterLabel.text = self.displayTimeNumbers(seconds: self.dailyCounter)
                    self.weekCounterLabel.text = self.displayTimeNumbers(seconds: self.weeklyCounter)
                    self.totalCounterLabel.text = self.displayTimeNumbers(seconds: self.totalCounter)
                    
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
        print("changed")
        if sender.isOn {
            locationManager.startUpdatingLocation()
        }
        else {
            locationManager.stopUpdatingLocation()
        }
    }
    func displayTimeNumbers(seconds: Double) -> String{
        let minutes = Int(seconds / 60)
        if minutes < 60 {
            return("\(minutes)m")
        }
        else {
            var hours = Int(minutes / 60)
            var remainderMins = Int(minutes % 60)
            return("\(hours)h \(remainderMins)m")
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
                    print("you are currently in the library")
                }
            }
            else {
                if isInLibrary == true {
                    print("you have left the library")
                    var totalTime = Date().timeIntervalSince1970 - lastFalseTime
                    print("TOTAL TIME:")
                    print(totalTime)
                    isInLibrary = false
                    if let email = Auth.auth().currentUser?.email {
                        if totalTime > 5 {
                            let docRef = db.collection(K.FStore.timeCollection).document()
                            docRef.setData([
                                K.FStore.emailField: email,
                                K.FStore.timeField: totalTime,
                                K.FStore.timeUpdated: Date().timeIntervalSince1970
                            ])
                        }
                    }
                    updateLabels()
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
    func updateLabels() {
        let docRef = db.collection(K.FStore.timeCollection)
    }
}

