//
//  AssetsEditViewController.swift
//  DazzlePanel
//
//  Created by For on 5/24/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit

class AssetsEditViewController: UIViewController {
    
    @IBOutlet weak var referenceView: UIView!
    @IBOutlet weak var makeView: UIView!
    @IBOutlet weak var modelView: UIView!
    @IBOutlet weak var nicknameView: UIView!
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var trackerView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.referenceView.layer.cornerRadius = 5
        self.makeView.layer.cornerRadius = 5
        self.modelView.layer.cornerRadius = 5
        self.nicknameView.layer.cornerRadius = 5
        self.yearView.layer.cornerRadius = 5
        self.trackerView.layer.cornerRadius = 5
        self.saveButton.layer.cornerRadius = 5
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
