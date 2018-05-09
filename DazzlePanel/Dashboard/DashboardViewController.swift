//
//  DashboardViewController.swift
//  DazzlePanel
//
//  Created by For on 5/24/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var speedView: UIView!
    @IBOutlet weak var circleProgress: KATCircularProgress!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.counterView.layer.cornerRadius = 12
        self.speedView.layer.cornerRadius = 12
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.addSliceItems()
        self.circleProgress.setAnimationDuration(2.5)
        self.circleProgress.reloadData()

    }
    
    func addSliceItems() {
        
        //clear the sliceItems array
        self.circleProgress.sliceItems.removeAllObjects()
        
        //Craete Slice items with value and section color
        let item1: SliceItem = SliceItem()
        item1.itemValue = 50.0
        item1.itemColor = UIColor.init(netHex: 0xBABABA)
        item1.itemWidth = 10.0
        
        let item2: SliceItem = SliceItem()
        item2.itemValue = 15.0
        item2.itemColor = UIColor.init(netHex: 0x4ED996)
        item2.itemWidth = 20.0
        
        let item3: SliceItem = SliceItem()
        item3.itemValue = 5.0
        item3.itemColor = UIColor.init(netHex: 0xC053BB)
        item3.itemWidth = 10.0
        
        let item4: SliceItem = SliceItem()
        item4.itemValue = 10.0
        item4.itemColor = UIColor.init(netHex: 0xFE9200)
        item4.itemWidth = 10.0
        
        let item5: SliceItem = SliceItem()
        item5.itemValue = 20.0
        item5.itemColor = UIColor.init(netHex: 0xE8E7EA)
        item5.itemWidth = 10.0
        
        //Add SliceItem objects to the sliceItems NSMutable array of KATProgressChart.
        self.circleProgress.sliceItems.add(item1)
        self.circleProgress.sliceItems.add(item2)
        self.circleProgress.sliceItems.add(item3)
        self.circleProgress.sliceItems.add(item4)
        self.circleProgress.sliceItems.add(item5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
