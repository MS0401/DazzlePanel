//
//  RouteStepInfoItem.swift
//  Tektiles
//
//  Created by DEV on 11/1/16.
//  Copyright © 2016 Dima. All rights reserved.
//

import Foundation
import CoreLocation

class RouteStepInfoItem {
    
    var distance: CLLocationDistance
    var duration: String
    var html_instructions: String
    var end_location: NSDictionary
    var instructions: String
    var start_location: NSDictionary
    var maneuver: String
    var encodedPolyline: String
    
    init(distance: CLLocationDistance, duration: String, html_instructions : String, instructions : String, maneuver: String, start_location: NSDictionary, end_location: NSDictionary, encodedPolyline: String) {
        
        self.distance = distance
        self.duration = duration
        self.html_instructions = html_instructions
        self.instructions = instructions
        self.maneuver = maneuver
        self.start_location = start_location
        self.end_location = end_location
        self.encodedPolyline = encodedPolyline
    }
    
    convenience init(item: NSDictionary) {
        
        let distance = item["distance"] as? CLLocationDistance
        let duration = item["duration"] as? String
        let html_instructions = item["html_instructions"] as? String
        let instructions = item["instructions"] as? String
        let maneuver = item["maneuver"] as? String
        let start_location = item["start_location"] as? NSDictionary
        let end_location = item["end_location"] as? NSDictionary
        let encodedPolyline = item["encodedPolyline"] as? String
        
        self.init(distance: distance!, duration: duration!, html_instructions: html_instructions!, instructions: instructions!, maneuver: maneuver!, start_location: start_location!, end_location: end_location!, encodedPolyline: encodedPolyline!)
        
    }
    
}