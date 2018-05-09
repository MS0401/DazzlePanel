//
//  AssetsViewCell.swift
//  DazzlePanel
//
//  Created by For on 5/26/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit

class AssetsViewCell: UITableViewCell {
    
    @IBOutlet weak var cell_ContentView: UIView!
    
    @IBOutlet weak var assetsType: UILabel!
    
    @IBOutlet weak var assetsDescribe: UILabel!
    @IBOutlet weak var assetsName: UILabel!
    @IBOutlet weak var assetsAddress: UILabel!
    @IBOutlet weak var requestTime: UILabel!
    @IBOutlet weak var runningDistance: UILabel!
    @IBOutlet weak var runningStateImage: UIImageView!
    
    
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cell_ContentView.layer.cornerRadius = 12
        self.cell_ContentView.layer.borderWidth = 2
        self.cell_ContentView.layer.borderColor = (UIColor(netHex: 0xF99B34)).cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
