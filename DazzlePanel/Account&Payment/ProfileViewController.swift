//
//  ProfileViewController.swift
//  DazzlePanel
//
//  Created by For on 6/9/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var avoidingView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var segmentHeight: NSLayoutConstraint!//43
    @IBOutlet weak var segmentTop: NSLayoutConstraint!//23
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var companyHeight: NSLayoutConstraint!//86
    @IBOutlet weak var companyTop: NSLayoutConstraint!//43
    @IBOutlet weak var companyText: UITextField!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var firstNameHeight: NSLayoutConstraint!//86
    @IBOutlet weak var firstNameTop: NSLayoutConstraint!//13
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var lastNameHeight: NSLayoutConstraint!//86
    @IBOutlet weak var lastNameTop: NSLayoutConstraint!//16
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var superViewHeight: NSLayoutConstraint!//918, back space = 65
    
    //profile staus
    var create: Bool = true
    
    //image picker initialize
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //keyboardAvoiding
       // KeyboardAvoiding.avoidingView = self.avoidingView
        //ImagePicker delegate
        self.imagePicker.delegate = self

        //View initialize
        self.companyText.layer.cornerRadius = 10
        self.firstNameText.layer.cornerRadius = 10
        self.lastNameText.layer.cornerRadius = 10
        self.phoneText.layer.cornerRadius = 10
        self.emailText.layer.cornerRadius = 10
        self.passwordText.layer.cornerRadius = 10
        self.saveButton.layer.cornerRadius = 10
        
        if create {
            self.segmentHeight.constant = 0
            self.segment.isHidden = true
            self.segmentTop.constant = 0
            self.companyHeight.constant = 0
            self.companyTop.constant = 0
            self.companyView.isHidden = true
            self.superViewHeight.constant = 987 - 43 - 86 - 43 - 23
        }else {
            self.companyHeight.constant = 0
            self.companyTop.constant = 0
            self.companyView.isHidden = true
            self.superViewHeight.constant = 987 - 86 - 65
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveAction(_ sender: UIButton) {
        
        let  vc =  self.navigationController?.viewControllers.filter({$0 is Account_BalanceViewController}).first
        
        (vc as! Account_BalanceViewController).profile_image = self.profileImage.image
        (vc as! Account_BalanceViewController).user_Email = self.emailText.text
        (vc as! Account_BalanceViewController).user_Name = self.firstNameText.text! + self.lastNameText.text!
        (vc as! Account_BalanceViewController).first = false
        self.navigationController?.popToViewController(vc!, animated: true)
    }

    //segmentControl Action
    @IBAction func SegmentActoin(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.companyHeight.constant = 0
            self.companyView.isHidden = true
            
            self.firstNameHeight.constant = 86
            self.firstNameView.isHidden = false
            self.lastNameHeight.constant = 86
            self.lastNameView.isHidden = false
            
            self.superViewHeight.constant = 987 - 86 - 65
        }else {
            self.firstNameHeight.constant = 0
            self.firstNameTop.constant = 0
            self.firstNameView.isHidden = true
            self.lastNameHeight.constant = 0
            self.lastNameTop.constant = 0
            self.lastNameView.isHidden = true
            
            self.companyHeight.constant = 86
            self.companyTop.constant = 23
            self.companyView.isHidden = false
            
            self.superViewHeight.constant = 987 - 86 - 86 - 65
        }
    }
    
    @IBAction func ProfileImageAction(_ sender: UIButton) {
        
        self.imagePicker.allowsEditing = false
        self.imagePicker.delegate = self
        self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.imagePicker.modalPresentationStyle = .popover
        self.imagePicker.sourceType = .photoLibrary// or savedPhotoAlbume
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate Mehtods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImage.backgroundColor = UIColor.clear
            self.profileImage.image = pickedImage
            self.CircleImage(profileImage: self.profileImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //making circle image
    func CircleImage(profileImage: UIImageView) {
        // Circle images
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = UIColor.clear.cgColor
        profileImage.clipsToBounds = true
        
    }
    
    //textFieldDelegate method
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //KeyboardAvoiding.avoidingView = self.avoidingView
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    
}
