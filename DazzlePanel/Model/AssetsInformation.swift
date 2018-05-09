//
//  AssetsInformation.swift
//  DazzlePanel
//
//  Created by For on 6/5/17.
//  Copyright © 2017 For. All rights reserved.
//

import Foundation
import UIKit

class AssetsInformation {
    
    var assetsType: String!
    var assetsDescribe: String!
    var assetsName: String!
    var assetsAddress: String!
    var requestTime: String!
    var runningDistance: String!
    var runningStateImage: UIImage!
    var imageName: String!
    init() {
        self.assetsType = ""
        self.assetsName = ""
        self.assetsDescribe = ""
        self.assetsAddress = ""
        self.requestTime = ""
        self.runningDistance = ""
        self.runningStateImage = UIImage.init()
        self.imageName = ""
    }
    
    init(type: String, describe: String, name: String, address: String, time: String, distance: String, image: UIImage!, imageName: String) {
        self.assetsType = type
        self.assetsDescribe = describe
        self.assetsName = name
        self.assetsAddress = address
        self.requestTime = time
        self.runningDistance = distance
        self.runningStateImage = image
        self.imageName = imageName
    }
    
    convenience init(dictionary: NSDictionary) {
        
        let type = dictionary["type"] as! String
        let describe = dictionary["describe"] as! String
        let name = dictionary["name"] as! String
        let address = dictionary["address"] as! String
        let time = dictionary["time"] as! String
        let distance = dictionary["distance"] as! String
        let imageName = dictionary["imageName"] as! String
        let image = UIImage(named: imageName)!
        
        self.init(type: type, describe: describe, name: name, address: address, time: time, distance: distance, image: image, imageName: imageName)
    }
}
