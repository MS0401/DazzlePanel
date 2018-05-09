//
//  ReportsMapViewCell.swift
//  DazzlePanel
//
//  Created by For on 6/8/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import Mapbox
import GoogleMaps
import GooglePlaces

class ReportsMapViewCell: UITableViewCell {
    
    @IBOutlet weak var reportsMap_mapbox: MGLMapView!
    @IBOutlet weak var reportsMap_googleMap: GMSMapView!
    @IBOutlet weak var displayInfoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.displayInfoView.layer.cornerRadius = 7
        self.displayInfoView.layer.shadowColor = UIColor.black.cgColor
        self.displayInfoView.layer.shadowOpacity = 0.16
        self.displayInfoView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.shareButton.layer.cornerRadius = self.shareButton.bounds.width/2 - 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
