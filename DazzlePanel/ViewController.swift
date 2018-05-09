//
//  ViewController.swift
//  DazzlePanel
//
//  Created by For on 5/23/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import CoreLocation
import AAViewAnimator

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var message: UILabel!
    
    //User Token when login
    var token: String!
    
    //Location Manager - CoreLocation Framework.
    var locationManager = CLLocationManager()
    
    // Declare for progress bar
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    var keyboardActive = false

    
    //Current location information
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    //NSTimer object for scheduling accuracy changes
    var backgroundTimer: Timer!
    var appDelegate: AppDelegate!
    
    // BackgroundTaskIdentifier for backgrond update location
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier!
    var backgroundTaskIdentifier2: UIBackgroundTaskIdentifier!
    
    var serverManager = ServerManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.message.isHidden = true
        self.token = ""
        
        //view initialize
        self.userEmail.layer.cornerRadius = 5
        self.userPassword.layer.cornerRadius = 5
        
        
        self.retrieveAccountInfo()
        
        self.loginButton.layer.cornerRadius = 12
        
        // Authorization for utilization of location services for background process
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            // Location Manager configuration
            locationManager.delegate = self
            
            // Location Accuracy, properties
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.allowsBackgroundLocationUpdates = true
            
            locationManager.startUpdatingLocation()
            
        }
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate


    }
    
    func retrieveAccountInfo() {
        
        let defaults = UserDefaults.standard
        
        if defaults.string(forKey: "tenancyName") != nil {
            
            self.userEmail.text = defaults.string(forKey: "userEmail")
            self.userPassword.text = defaults.string(forKey: "userPassword")
        }
    }

    
    @IBAction func LoginAction(_ sender: UIButton) {
        
        self.message.isHidden = true
        
        // Load Progress bar
        self.progressBarDisplayer("Login...", true)
        
        //Disable all inputs
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let useremail = self.userEmail.text!
        let userpassword = self.userPassword.text!
        
        let defaults = UserDefaults.standard
        
        defaults.set(useremail, forKey: "userEmail")
        defaults.set(userpassword, forKey: "userPassword")
        
        // Set request parameters
        let parameters = ["userEmail": useremail, "userPassword": userpassword]
        
        self.serverManager.loginRequest(parameters as NSDictionary, withCompletionHandler: { (success) -> Void in
            
            if success {
                if self.latitude != nil && self.longitude != nil {
                    
                    //Get Token information
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        SharedManager.sharedInstance.token = self.serverManager.userToken
                        self.updateLocation()
                        self.appDelegate.postTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(ViewController.updateLocation), userInfo: nil, repeats: true)
                    })
                    
                    print("LOGIN success")
                    
                    //go to the next page.
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        self.appDelegate.tokenTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(ViewController.sendLoginRequest), userInfo: nil, repeats: true)
                        self.message.isHidden = true
//                        let tabController = self.storyboard?.instantiateViewController(withIdentifier: "manageTab") as! TabBarViewController
//                        self.present(tabController, animated: true, completion: nil)
                    })
                } else {
                    self.animateSender(sender)
                    
                    // Display error message
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        self.message.text = "GPS error. Check GPS status and try again."
                        self.message.isHidden = false
                        
                    })
                }
            }else {
                print("Login Error")
                
                self.animateSender(sender)
                
                //Display error message
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.message.text = "Input error. Enter correct information"
                    self.message.isHidden = false
                })
            }
            
            // Remove Progress
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                //Remove progress bar
                self.messageFrame.removeFromSuperview()
                
                //Enable all inputs
                UIApplication.shared.endIgnoringInteractionEvents()
            })
        })
    }
            
    func sendLoginRequest() {
                
        let defaults = UserDefaults.standard
        
        let useremail = defaults.string(forKey: "userEmail")!
        let userpassWord = defaults.string(forKey: "userPassword")!
                
                
        // Set request parameters
        let parameters = ["userEmail": useremail, "userPassword": userpassWord]
                
        self.serverManager.loginRequest(parameters as NSDictionary, withCompletionHandler: { (success) -> Void in
                    
            if success {
                print("LOGIN SUCCESS")
                        
                // Get Token information
                SharedManager.sharedInstance.token = self.serverManager.userToken
                        self.token = SharedManager.sharedInstance.token
            } else {
                print("LOGIN ERROR")
            }
                    
        })
    }

            
    func updateLocation() {
                
        let timeRemaining = UIApplication.shared.backgroundTimeRemaining
                
        print("BackgroundTimeRemaining => \(timeRemaining)")
        //        self.token = SharingManager.sharedInstance.token
                
        if timeRemaining > 60.0 {
                    
            if self.latitude != nil && self.longitude != nil {
                        
                // Send current location and time to server
                self.geoLogLocation(self.latitude, lng: self.longitude)
                        
            }
        } else {
                    
            if timeRemaining == 0 {
                        
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
            backgroundTaskIdentifier2 = UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in
                        
                // Stops Timer
                self.backgroundTimer.invalidate()
                        
                /* Timer initialized everytime an update is received. When timer expires, reverts accuracy to HiGH, thus enabling the delegate to receive new location updates */
                self.backgroundTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(ViewController.updateLocation), userInfo: nil, repeats: true)
            })
        }
    }
            
    // Send current location and time with Json data to server
    func geoLogLocation(_ lat: CLLocationDegrees, lng: CLLocationDegrees) {
                
        if token != "" {
                    
            // Location information
            let location = "\(lat), \(lng)"
            print(location)
                    
            // Time information
            let timeStamp = self.getDate()
            print(timeStamp)
                    
            let childUrl = "location/SetLocation"
                    
            // Set request parameters
            let parameters = ["location": location, "timeStamp": timeStamp]
                    
            self.serverManager.createSetRequest(childUrl, parameters: parameters as NSDictionary, withCompletionHandler: { (success) -> Void in
                        
                if !success {
                    print("SetLocation ERROR")
                } else {
                    print("SetLocation SUCCESS")
                }
                        
            })
        }
    }
        
    // Ger current datetime information
    func getDate() -> String {
                
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                
        return dateFormatter.string(from: now)
                
    }

    
    func progressBarDisplayer(_ msg:String, _ indicator:Bool ) {
        
        print("message => \(msg)")
        
        // Set progressbar label
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 150, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        
        // Set messageframe
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 60, y: view.frame.midY - 25 , width: 120, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        // Set activityIndicator
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        
        // Add messageframe into superview
        view.addSubview(messageFrame)
    }
    
    func animateSender(_ sender: UIButton) {
        sender.aa_animate(duration: 0.05, springDamping: .slight, animation: .vibrateX(rate:5), completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - CLLocationManagerDelegate
extension ViewController:  CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        SharedManager.sharedInstance.currentLoc = locValue
        SharedManager.sharedInstance.currentLocation = "\(locValue.latitude), \(locValue.longitude)"
        
        if UIApplication.shared.applicationState == .active {
            
        } else {
            
            backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in
                
                // Stops Timer
                self.backgroundTimer.invalidate()
                
                /* Timer initialized everytime an update is received. When timer expires, reverts accuracy to HiGH, thus enabling the delegate to receive new location updates */
                self.backgroundTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(ViewController.updateLocation), userInfo: nil, repeats: true)
                
            })
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension UIColor {
    
    // Convert UIColor from Hex to RGB
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
}

