//
//  UserMapViewController.swift
//  DazzlePanel
//
//  Created by For on 6/6/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Mapbox

class UserMapViewController: UIViewController {
    
    @IBOutlet weak var mapBoxView: MGLMapView!
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchHistory: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var mapTypeButton: UIButton!
    @IBOutlet weak var changeMap: UIButton!
    
    //Google Map property defines
    var locationManager = CLLocationManager()
    var mapTasks = MapTasks()
    
    var locationMarker: GMSMarker!
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    var usersMarker = [GMSMarker]()
    var routePolyline: GMSPolyline!
    
    // Address Array
    var addressList = [String]()
    
    // CLLocationCoordinate2D Array
    var coordinates = [CLLocationCoordinate2D]()
    
    // Camera Location Dictionary
    var cameraLocation = [String: Double]()
    
    var flag: Bool = true
    
    var appDelegate: AppDelegate!
    var estimatedDuration: Int!
    // Check locations of others.
    var isDisplayed = false
    
    // Other users location array
    var locationInfoArray = [LocationInfoItem]()
    var serverManager = ServerManager()
    
    
    //property define
    var change_map: Bool = true // Changing Google Map or Mapbox.
    var mapType: Bool = true // Changing hybrid or satallite.
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if change_map {
            self.mapBoxView.isHidden = false
            self.googleMapView.isHidden = true
        }else {
            self.mapBoxView.isHidden = true
            self.googleMapView.isHidden = false
        }
        
        //searchBar initialize///
        
        for subView in searchBar.subviews {
            for view in subView.subviews {
                if view.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                    let imageView = view as! UIImageView
                    imageView.layer.cornerRadius = 10
                }
            }
        }
        
        
        self.searchBar.placeholder = self.setPlaceHolder(placeholder: "Search Assets")
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        //textFieldInsideSearchBar?.backgroundColor = UIColor.init(netHex: 0xF5F5F5)
        textFieldInsideSearchBar?.font = UIFont(name: "Helvetica", size: 22.0)
        textFieldInsideSearchBar?.leftViewMode = UITextFieldViewMode.never
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffsetMake(0, 0)


        
        //searchBar initialize
        self.searchBar.layer.borderWidth = 0.5
        self.searchBar.layer.borderColor = UIColor.white.cgColor

        //View initialize
        self.searchView.layer.cornerRadius = 7
        self.searchView.layer.shadowColor = UIColor.black.cgColor
        self.searchView.layer.shadowOpacity = 0.16
        self.searchView.layer.borderWidth = 0.0
        //self.searchView.layer.borderColor = UIColor.gray.cgColor
        self.searchView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.plusButton.layer.cornerRadius = self.plusButton.bounds.width/2 - 5
        self.minusButton.layer.cornerRadius = self.minusButton.bounds.width/2 - 5
        self.addressView.layer.cornerRadius = 20
        self.shareButton.layer.cornerRadius = self.shareButton.bounds.width/2 - 5
        self.mapTypeButton.layer.cornerRadius = self.mapTypeButton.bounds.width/2 - 5
        self.changeMap.layer.cornerRadius = 20
        
        self.changeMap.setTitle("Google Map", for: .normal)
        
        // Do any additional Google Map setup after loading the view
        googleMapView.delegate = self
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Get location information of other user from server
        self.getLocationForUsers()
        appDelegate.otherLocationTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(UserMapViewController.getLocationForUsers), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.GoogleMap_Initialize()
    }
    
    // Google Map initialize
    func GoogleMap_Initialize() {
        if SharedManager.sharedInstance.isUpdated {
            SharedManager.sharedInstance.isUpdated = false
            
            // Clear MapView
            googleMapView.clear()
            
            // Initialize addres list and index
            self.addressList.removeAll()
            self.coordinates.removeAll()
            
            locationManager.delegate = self
            
            // Request permission to use Location service
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            
            // Start the update of user's Location
            locationManager.startUpdatingLocation()
            
            let mapInsets = UIEdgeInsets(top: 80.0, left: 0.0, bottom: 0.0, right: 0.0)
            googleMapView.padding = mapInsets
            
            // Initialize Camera Location
            let currentLocation = SharedManager.sharedInstance.currentLoc
            cameraLocation = ["lat": (currentLocation?.latitude)!, "lng": (currentLocation?.longitude)!, "count": 1.0, "totalLat": (currentLocation?.latitude)!, "totalLng": (currentLocation?.longitude)!]
            
            // Display all assets on GoogleMap
            if locationInfoArray.count == 0 {
                //self.showAlert("Sorry!", message: "There isn't any other user logged in.")
            }else {
                self.displayAssetsLocation()
            }
            
        }

    }
    
    // Display all assets on Google map
    func displayAssetsLocation() {
        
        usersMarker.removeAll()
        for item in locationInfoArray {
            
            let coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            let userMarker = GMSMarker(position: coordinate)
            userMarker.map = googleMapView            
            
            userMarker.appearAnimation = GMSMarkerAnimation.pop
            userMarker.icon = UIImage(named: item.markerType)
            userMarker.rotation = item.rotationAngle
            usersMarker.append(userMarker)
            
        }

    }
    
    // Get Location of other users from server
    func getLocationForUsers() {
        
        let childUrl = "location/getLocationsForAllUsers"
        
        self.serverManager.createGetRequest(childUrl, withCompletionHandler: { (success) -> Void in
            
            if !success {
                print("getLocationForAllUsers ERROR")
            } else {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    print("getLocationForAllUsers SUCCESS")
                    self.parseUserLocationInfo(self.serverManager.items)
                })
                
            }
            
        })
    }
    
    // Parse location information of other users
    func parseUserLocationInfo(_ items: NSArray) {
        
        self.locationInfoArray.removeAll()
        for item in items {
            
            // Get information of users
            let dict = item as! NSDictionary
            let username = dict["userName"] as? String
            let recievedTimeStamp = dict["recievedTimeStamp"] as? String
            let location = dict["location"] as? String
            
            // Check if special value is not "nil"
            if username != nil && recievedTimeStamp != nil && location != nil {
                
                // When is user location submitted?
                let differenceForMinutes = self.calculateDifferencFromNow(recievedTimeStamp!)
                print("\(username!) is submitted before \(differenceForMinutes)min")
                
                if username!.lowercased() != SharedManager.sharedInstance.loginUser && differenceForMinutes < 3 {
                    
                    let locationInfoItem = LocationInfoItem(dictionary: dict)
                    self.locationInfoArray.append(locationInfoItem)
                }
            }
        }
    }
    
    func calculateDifferencFromNow(_ dateString: String) -> Int {
        
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var submitDate = dateFormatter.date(from: dateString)
        
        if submitDate == nil {
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            submitDate = dateFormatter.date(from: dateString)
        }
        
        return now.minutesFrom(submitDate!)
    }

    //changing search bar placeholder textalign.
    func setPlaceHolder(placeholder: String)-> String
    {
        
        var text = placeholder
        if text.characters.last! != " " {
            
            //                         define a max size
            
            let maxSize = CGSize(width: UIScreen.main.bounds.size.width - 97, height: 40)
            
            //                        let maxSize = CGSizeMake(self.bounds.size.width - 92, 40)
            // get the size of the text
            let widthText = text.boundingRect( with: maxSize, options: .usesLineFragmentOrigin, attributes:nil, context:nil).size.width
            // get the size of one space
            let widthSpace = " ".boundingRect( with: maxSize, options: .usesLineFragmentOrigin, attributes:nil, context:nil).size.width
            let spaces = floor((maxSize.width - widthText) / widthSpace)
            // add the spaces
            let newText = text + ((Array(repeating: " ", count: Int(spaces)).joined(separator: "")))
            // apply the new text if nescessary
            if newText != text {
                return newText
            }
            
        }
        
        return placeholder;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Search_History(_ sender: UIButton) {
    }
    @IBAction func ZoomPlus(_ sender: UIButton) {
    }
    @IBAction func ZoomMinus(_ sender: UIButton) {
    }
    @IBAction func ChangeMap(_ sender: UIButton) {
        if change_map {
            self.changeMap.setTitle("MapBox", for: .normal)
            
            self.googleMapView.mapType = .normal
            self.mapBoxView.isHidden = true
            self.googleMapView.isHidden = false

            UIView.animate(withDuration: 0.1, animations: {
                self.GoogleMap_Initialize()
            })

            self.change_map = false
        }else {
            self.changeMap.setTitle("Google Map", for: .normal)
            
            self.googleMapView.clear()
            self.googleMapView.isHidden = true
            self.mapBoxView.isHidden = false
            self.change_map = true
        }
    }
    
    @IBAction func ChangeMapType(_ sender: UIButton) {
        if change_map {
            if self.mapType {
                self.mapBoxView.styleURL = MGLStyle.satelliteStreetsStyleURL(withVersion: 9)
                self.mapType = false
            }else {
                self.mapBoxView.styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
                self.mapType = true
            }
        }else {
            if self.mapType == true {
                
                self.googleMapView.mapType = .hybrid
                self.mapType = false
            }else {
                self.googleMapView.mapType = .normal
                self.mapType = true
            }
        }
    }
    
    // Display Alert View
    func showAlert(_ title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alertView.view.tintColor = UIColor(netHex: 0xFF7345)
        
        self.present(alertView, animated: true, completion: nil)
    }
    
}

extension UserMapViewController: GMSMapViewDelegate {
    
    //MARK: GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        // Get a reference for the custom overlay
        //let index:Int! = Int(marker.accessibilityLabel!)
        let customInfoWindow = Bundle.main.loadNibNamed("Assets_infoWindow", owner: self, options: nil)?[0] as! Assets_infowindowView
        customInfoWindow.title.text = "LPY-532"
        customInfoWindow.layer.cornerRadius = 8
        return customInfoWindow
    }

}

extension UserMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            locationManager.stopUpdatingLocation()
        }
    }
}

extension Date {
    func minutesFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
}

