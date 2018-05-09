//
//  ReportsMapViewController.swift
//  DazzlePanel
//
//  Created by For on 6/8/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Mapbox

class ReportsMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var reportsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.reportsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reportsMap")
        //self.reportsTableView.register(UI, forCellReuseIdentifier: "reportsMap")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TableView delegate and Datasource confirmation.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportsMap", for: indexPath) as! ReportsMapViewCell
        cell.infoLabel.text = "\(indexPath.row + 1)"
        
        return cell
    }
}
