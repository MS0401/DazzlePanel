//
//  PlanViewController.swift
//  DazzlePanel
//
//  Created by For on 6/9/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController {
    
    @IBOutlet weak var superView: NSLayoutConstraint!//981
    
    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var basic_subView: UIView!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var advanceView: UIView!
    @IBOutlet weak var preminu_subView1: UIView!
    @IBOutlet weak var premium_subView2: UIView!
    @IBOutlet weak var premiumView: UIView!
    @IBOutlet weak var cancelSubscribeBtn: UIButton!
    @IBOutlet weak var policy_DescriptionView: UIView!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var policyView: UIView!
    @IBOutlet weak var premiumConstraint: NSLayoutConstraint!//198
    @IBOutlet weak var premiumHeight: NSLayoutConstraint!//283
    @IBOutlet weak var policyConstraint: NSLayoutConstraint!//280
    @IBOutlet weak var policyHeight: NSLayoutConstraint!//330
    @IBOutlet weak var basicArrow: UIImageView!
    @IBOutlet weak var premiumArrow: UIImageView!
    @IBOutlet weak var policyArrow: UIImageView!
    @IBOutlet weak var basicHeight: NSLayoutConstraint!//264
    @IBOutlet weak var basicConstraint: NSLayoutConstraint!//192
    
    var basic: Bool = true
    var premium: Bool = true
    var policy: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        //View initialize
        self.basicView.layer.cornerRadius = 5
        self.basicView.layer.borderWidth = 2.5
        self.basicView.layer.borderColor = UIColor.init(hex: 0xFF8334).cgColor
        self.subscribeBtn.layer.cornerRadius = 5
        self.advanceView.layer.cornerRadius = 5
        self.advanceView.layer.borderWidth = 2.5
        self.advanceView.layer.borderColor = UIColor.init(hex: 0x34FF71).cgColor
        self.cancelSubscribeBtn.layer.cornerRadius = 5
        self.premiumView.layer.cornerRadius = 5
        self.premiumView.layer.borderWidth = 2.5
        self.premiumView.layer.borderColor = UIColor.init(hex: 0x349EFF).cgColor
        
        //basic View initialize
        self.basicConstraint.constant = 0
        self.basicHeight.constant = 75
        self.basic_subView.isHidden = true
        self.basicArrow.image = UIImage(named: "arrow_down")
        
        //premium View initialize
        self.premiumConstraint.constant = 0
        self.premiumHeight.constant = 75
        self.premium_subView2.isHidden = true
        self.premiumArrow.image = UIImage(named: "arrow_down")
        
        //policy View initialize
        self.policyConstraint.constant = 0
        self.policyHeight.constant = 50
        self.policy_DescriptionView.isHidden = true
        self.policyArrow.image = UIImage(named: "arrow_down")
        
        //super View adjust constraint
        self.superView.constant = 1178 - 198 - 280 - 192
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PremiumAction(_ sender: UIButton) {
        if premium {
            self.premiumConstraint.constant = 198
            self.premiumHeight.constant = 283
            self.premium_subView2.isHidden = false
            self.premiumArrow.image = UIImage(named: "arrow_up")
            self.premium = false
        }else {
            self.premiumConstraint.constant = 0
            self.premiumHeight.constant = 75
            self.premium_subView2.isHidden = true
            self.premiumArrow.image = UIImage(named: "arrow_down")
            self.premium = true
        }
        
        if premium && policy && basic {
            self.superView.constant = 508
        }else if !premium && policy && basic {
            self.superView.constant = 706
        }else if premium && !policy && basic {
            self.superView.constant = 788
        }else if !premium && !policy && basic {
            self.superView.constant = 986
        }else if premium && !policy && !basic {
            self.superView.constant = 980
        }else if !premium && !policy && !basic {
            self.superView.constant = 1178
        }else if premium && policy && !basic {
            self.superView.constant = 700
        }else if !premium && policy && !basic {
            self.superView.constant = 898
        }
    }

    @IBAction func PolicyAction(_ sender: UIButton) {
        if policy {
            self.policyConstraint.constant = 280
            self.policyHeight.constant = 330
            self.policy_DescriptionView.isHidden = false
            self.policyArrow.image = UIImage(named: "arrow_up")
            self.policy = false
        }else {
            self.policyConstraint.constant = 0
            self.policyHeight.constant = 50
            self.policy_DescriptionView.isHidden = true
            self.policyArrow.image = UIImage(named: "arrow_down")
            self.policy = true
        }
        
        if premium && policy && basic {
            self.superView.constant = 508
        }else if !premium && policy && basic {
            self.superView.constant = 706
        }else if premium && !policy && basic {
            self.superView.constant = 788
        }else if !premium && !policy && basic {
            self.superView.constant = 986
        }else if premium && !policy && !basic {
            self.superView.constant = 980
        }else if !premium && !policy && !basic {
            self.superView.constant = 1178
        }else if premium && policy && !basic {
            self.superView.constant = 700
        }else if !premium && policy && !basic {
            self.superView.constant = 898
        }
    }
    
    @IBAction func BasicAction(_ sender: UIButton) {
        if basic {
            self.basicConstraint.constant = 192
            self.basicHeight.constant = 264
            self.basic_subView.isHidden = false
            self.basicArrow.image = UIImage(named: "arrow_up")
            self.basic = false
        }else {
            self.basicConstraint.constant = 0
            self.basicHeight.constant = 75
            self.basic_subView.isHidden = true
            self.basicArrow.image = UIImage(named: "arrow_down")
            self.basic = true
        }
        
        if premium && policy && basic {
            self.superView.constant = 508
        }else if !premium && policy && basic {
            self.superView.constant = 706
        }else if premium && !policy && basic {
            self.superView.constant = 788
        }else if !premium && !policy && basic {
            self.superView.constant = 986
        }else if premium && !policy && !basic {
            self.superView.constant = 980
        }else if !premium && !policy && !basic {
            self.superView.constant = 1178
        }else if premium && policy && !basic {
            self.superView.constant = 700
        }else if !premium && policy && !basic {
            self.superView.constant = 898
        }
    }
    
}
