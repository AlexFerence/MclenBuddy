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
    
    static let latitudeMin = 45.50764422402299
    static var latitudeMax = 100.00
    static var longitudeMin = -100.00
    static var longitudeMax = 100.00
    
    static func isInLibrary(latitude: Double, longitude: Double) -> Bool {
        if (latitude > latitudeMin && latitude < latitudeMax && latitude > longitudeMin && latitude < longitudeMax) {
            return true
        }
        else {
            return false
        }
    }
    
}
