//
//  Account+BalanceViewController.swift
//  DazzlePanel
//
//  Created by For on 5/24/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit

class Account_BalanceViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UITextField!
    
    // tempory variable
    var profile_image: UIImage!
    var user_ID: String!
    var user_Name: String!
    var user_Email: String!
    
    
    @IBOutlet weak var balance_subView: UIView!
    @IBOutlet weak var subscriptionView: UIView!
    @IBOutlet weak var balanceView_Constraint: NSLayoutConstraint!
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var addPaymentView: UIView!
    @IBOutlet weak var addPaymentBtn1: UIButton!
    @IBOutlet weak var trackSwitch: UISwitch!
    @IBOutlet weak var cancel1: UIButton!
    @IBOutlet weak var cancel2: UIButton!
    @IBOutlet weak var visaText: UITextField!
    @IBOutlet weak var cardText: UITextField!
    
    var first: Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()     
        
        
        // View initialize
        self.balance_subView.layer.cornerRadius = 5
        self.subscriptionView.layer.borderWidth = 3
        self.subscriptionView.layer.borderColor = UIColor.init(hex: 0x339EFF).cgColor
        self.subscriptionView.layer.cornerRadius = 5
        self.cancel1.isHidden = true
        self.cancel2.isHidden = true
        self.addPaymentView.isHidden = true
        self.addPaymentBtn1.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !first {
            self.profileImage.image = self.profile_image
            self.CircleImage(profileImage: self.profileImage)
            var id: Int = Int()
            if id < 1 {
                id = 1
            }
            self.user_ID = "\(id)"
            self.userID.text = self.user_ID
            id += id + 1
            self.userName.text = self.user_Name
            self.userEmail.text = self.user_Email
        }
        
    }
    
    //making circle image
    func CircleImage(profileImage: UIImageView) {
        // Circle images
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = UIColor.clear.cgColor
        profileImage.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Set back bar item
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func TrackerSwitch(_ sender: UISwitch) {
        
        if trackSwitch.isOn {
            self.balanceView.isHidden = true
            self.balanceView_Constraint.constant = 0.0
            self.cancel1.isHidden = false
            self.cancel2.isHidden = false
            self.addPaymentView.isHidden = false
            self.addPaymentBtn1.isHidden = true
        } else {
            self.balanceView.isHidden = false
            self.balanceView_Constraint.constant = 83.0
            self.cancel2.isHidden = true
            self.cancel1.isHidden = true
            self.addPaymentView.isHidden = true
            self.addPaymentBtn1.isHidden = false
        }
    }

    @IBAction func ProfileSegueAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "profile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "profile" {
            let profile = segue.destination as! ProfileViewController
            
            if self.profileImage != nil && self.userID.text != "" && self.userName.text != "" && self.userEmail.text != "" {
                profile.create = false
            }
        }
    }
   
}

extension Account_BalanceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
