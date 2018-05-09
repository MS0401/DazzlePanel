//
//  RouteInfoItem.swift
//  Tektiles
//
//  Created by DEV on 10/22/16.
//  Copyright © 2016 Dima. All rights reserved.
//

import Foundation

class RouteInfoItem {
    
    var drivetime: String
    var mileage: String
    var drivetimeSub : String
    var mileageSub: String
    var duration: Int
    var drivingHidden: Bool
    
    init(drivetime: String, mileage: String, drivetimeSub : String, mileageSub : String, duration: Int, drivingHidden: Bool) {
        
        self.drivetime = drivetime
        self.mileage = mileage
        self.drivetimeSub = drivetimeSub
        self.mileageSub = mileageSub
        self.duration = duration
        self.drivingHidden = drivingHidden
        
    }
    
    convenience init(item: NSDictionary) {
        
        let drivetime = item["drivetime"] as? String
        let mileage = item["mileage"] as? String
        let drivetimeSub = item["drivetimeSub"] as? String
        let mileageSub = item["mileageSub"] as? String
        let duration = item["duration"] as? Int
        let drivingHidden = item["drivingHidden"] as? Bool
        
        self.init(drivetime: drivetime!, mileage: mileage!, drivetimeSub: drivetimeSub!, mileageSub: mileageSub!, duration: duration!, drivingHidden: drivingHidden!)
        
    }
    
}