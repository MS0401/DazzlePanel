//
//  SharedManager.swift
//  DazzlePanel
//
//  Created by For on 5/29/17.
//  Copyright © 2017 For. All rights reserved.
//

import Foundation
import CoreLocation

class SharedManager {
    
    static let sharedInstance = SharedManager()
    
    //user token information
    var token: String = ""
    
    //Login information
    var loginUser = ""
    
    //Current location
    var currentLocation = ""
    var currentLoc: CLLocationCoordinate2D!
    
    //Destination location
    var destinationLocation = ""
    var destinationLoc: CLLocationCoordinate2D!
    
    // Refresh State
    var isRefreshed = true
    var isUpdated = true
}
