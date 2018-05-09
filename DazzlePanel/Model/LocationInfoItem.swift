//
//  LocationInfoItem.swift
//  DazzlePanel
//
//  Created by For on 6/6/17.
//  Copyright © 2017 For. All rights reserved.
//

import Foundation

class LocationInfoItem {
    
    var assetsType: String!
    var assetsDescribe: String!
    var assetsName: String!
    var requestTime: String!
    var latitude: Double!
    var longitude: Double!
    var markerType: String!
    var rotationAngle: Double!
    
    init() {
        self.assetsType = ""
        self.assetsName = ""
        self.assetsDescribe = ""
        self.requestTime = ""
        self.latitude = 0.0
        self.longitude = 0.0
        self.markerType = ""
    }
    
    init (type: String, describe: String, name: String, time: String, location: String, markerType: String, rotationAngle: Double) {
        
        self.assetsType = type
        self.assetsName = name
        self.assetsDescribe = describe
        self.requestTime = time
        let strSplit = location.components(separatedBy: ", ")
        let lat = strSplit.first
        let lng = strSplit.last
        
        self.latitude = Double(lat!)!
        self.longitude = Double(lng!)!
        self.markerType = markerType
        self.rotationAngle = rotationAngle
    }
    
    convenience init(dictionary: NSDictionary) {
        
        let type = dictionary["assetsType"] as! String
        let describe = dictionary["assetsDescribe"] as! String
        let name = dictionary["assetsName"] as! String
        let time = dictionary["requestTime"] as! String
        let location = dictionary["location"] as! String
        let markerType = dictionary["markerType"] as! String
        let rotationAngle = dictionary["rotationAngle"] as! Double
        
        self.init(type: type, describe: describe, name: name, time: time, location: location, markerType: markerType, rotationAngle: rotationAngle)
    }
}
