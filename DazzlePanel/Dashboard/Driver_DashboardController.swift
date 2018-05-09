//
//  Driver_DashboardController.swift
//  DazzlePanel
//
//  Created by For on 5/26/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit

class Driver_DashboardController: UIViewController {
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var clockButton: UIButton!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var speedView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.startView.layer.cornerRadius = 12
        self.clockButton.layer.cornerRadius = 12
        self.counterView.layer.cornerRadius = 12
        self.speedView.layer.cornerRadius = 12
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
