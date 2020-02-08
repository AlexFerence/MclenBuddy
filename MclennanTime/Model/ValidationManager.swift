//
//  LocationManager.swift
//  MclennanTime
//
//  Created by Alex Ference on 2020-02-01.
//  Copyright © 2020 Alex Ference. All rights reserved.
//

import Foundation

struct ValidationManager {
    
    var isInLibrary = false
    
    static let latitudeMin = 45.502910
    static var latitudeMax = 45.503716
    static var longitudeMax = -73.576430
    static var longitudeMin = -73.575459
    
//    static let latitudeMin = 0.0
//    static var latitudeMax = 37.33417925
//    static var longitudeMin = 0.0
//    static var longitudeMax = 15037.33065643
    
    static func isInLibrary(latitude: Double, longitude: Double) -> Bool {
        if (latitude > latitudeMin && latitude < latitudeMax && longitude < longitudeMin && longitude > longitudeMax) {
            return true
        }
        else {
            return false
        }
    }
    
}
