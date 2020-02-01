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
        
        
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        return manager
    }()
}

extension LocationViewController: CLLocationManagerDelegate {
    
}

