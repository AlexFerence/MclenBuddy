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
    static var longitudeMin = -73.576430
    static var longitudeMax = -73.575459
    
    static func isInLibrary(latitude: Double, longitude: Double) -> Bool {
        if (latitude > latitudeMin && latitude < latitudeMax && latitude > longitudeMin && latitude < longitudeMax) {
            return true
        }
        else {
            return false
        }
    }
    
}
