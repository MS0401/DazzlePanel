//
//  AssetsScreenViewController.swift
//  DazzlePanel
//
//  Created by For on 5/24/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Mapbox
import WYPopoverController


class AssetsScreenViewController: UIViewController {
    
    //WYPopoverController initialize
    var settingsPopoverController : WYPopoverController!
    var anotherPopoverController: WYPopoverController!

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var mapTypeButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    
    //Map View outlet.
    @IBOutlet weak var mapBoxView: MGLMapView!
    @IBOutlet weak var googleMapView: GMSMapView!
    
    
    
    
    let locationManager = CLLocationManager()
    var didFindMyLocation = false
    //initialize an object of the Maptasks class.
    
    var maptasks = MapTasks()
    var locationMaker: GMSMarker!
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    var usersMarker = [GMSMarker]()
    var routePolyline: GMSPolyline!
    // CLLocationCoordinate2D Array
    var coordinates = [CLLocationCoordinate2D]()
    var currentPlace = CLLocationCoordinate2D()
    // Camra Location Dictionary
    var cameraLocation = [String: Double]()
    
    //initialize mapbox
    var mapbox_locationMakerView: MGLUserLocationAnnotationView!
    var mapbox_locationMakericon: MGLAnnotationImage!
    
    //View properties
    var changeMapView: Bool = true // Changing into Google Map or Mapbox.
    var mapType: Bool = true // Hybrid or satalite changing.
    var currentZoom: Float = 15.0
    var currentZoom_mapbox: Double = 15.0
    var bubbleMode = true
    let maxAlpha: CGFloat = 0.75
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View initialize
        self.infoView.layer.cornerRadius = 7
        self.infoView.layer.shadowColor = UIColor.gray.cgColor
        self.infoView.layer.shadowOpacity = 0.16
        self.infoView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.plusButton.layer.cornerRadius = self.plusButton.bounds.width/2 - 5
        self.minusButton.layer.cornerRadius = self.minusButton.bounds.width/2 - 5
        self.addressView.layer.cornerRadius = 20
        self.shareButton.layer.cornerRadius = self.shareButton.bounds.width/2 - 5
        self.mapTypeButton.layer.cornerRadius = self.mapTypeButton.bounds.width/2 - 5
        
        
        self.mapView.isHidden = true
        self.mapBoxView.isHidden = false
        
        
        
        //Mapbox loading
        self.mapBoxView.delegate = self
        let point = MGLPointAnnotation()
        point.coordinate = SharedManager.sharedInstance.currentLoc
        self.mapBoxView.setCenter(point.coordinate, zoomLevel: 15, animated: true)
        self.mapBoxView.addAnnotation(point)
       
        self.GoogleMapInitialize()
        
    }
    
    
    @IBAction func ChangeMapView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.mapView.clear()
            self.mapView.isHidden = true
            self.mapBoxView.isHidden = false
            self.changeMapView = true
            break
        case 1:
            mapView.delegate = self
            self.mapView.mapType = .normal
            self.mapBoxView.isHidden = true
            self.mapView.isHidden = false
            self.changeMapView = false
            UIView.animate(withDuration: 0.1, animations: {
                self.GoogleMapInitialize()
            })
            break
        default:
            break
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    func GoogleMapInitialize() {
        mapView.clear()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        // Start the update of user's Location
        // Start the update of user's Location
        if CLLocationManager.locationServicesEnabled() {
            
            
            locationManager.delegate = self
            // Location Accuracy, properties
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.allowsBackgroundLocationUpdates = true
            
            locationManager.startUpdatingLocation()
            
            let cameraCoordinate = SharedManager.sharedInstance.currentLoc
            self.mapView.camera = GMSCameraPosition(target: cameraCoordinate!, zoom: 15, bearing: 0, viewingAngle: 0)
            self.setupLocationMarker(cameraCoordinate!)
            
            let geocoder = GMSGeocoder()
            
            geocoder.reverseGeocodeCoordinate(cameraCoordinate!) { response , error in
                if let address = response?.firstResult() {
                    let lines = address.lines! as [String]
                    
                    let current_Address = lines.joined(separator: "")
                    print("my address is \(current_Address)")
                    self.addressLabel.text = current_Address
                }
            }
            
        }

    }
    
    @IBAction func ChangeMapType(_ sender: UIButton) {
        
        if self.changeMapView {
            if self.mapType {
                self.mapBoxView.styleURL = MGLStyle.satelliteStreetsStyleURL(withVersion: 9)
                self.mapType = false
            }else {
                self.mapBoxView.styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
                self.mapType = true
            }
        }else {
            if self.mapType == true {
                
                self.mapView.mapType = .hybrid
                self.mapType = false
            }else {
                self.mapView.mapType = .normal
                self.mapType = true
            }
        }
    }
    
    @IBAction func ZoomPlus(_ sender: UIButton) {
        if self.changeMapView {
            self.currentZoom_mapbox = self.currentZoom_mapbox + 0.5
            self.mapBoxView.setZoomLevel(self.currentZoom_mapbox, animated: true)
        }else {
            currentZoom += 0.5
           self.mapView.animate(toZoom: currentZoom)
        }
    }
    @IBAction func ZoomMinus(_ sender: UIButton) {
        if self.changeMapView {
            self.currentZoom_mapbox = self.currentZoom_mapbox - 0.5
            self.mapBoxView.setZoomLevel(self.currentZoom_mapbox, animated: true)
        }else {
            currentZoom -= 0.5
            self.mapView.animate(toZoom: currentZoom)
        }
    }
    
    func setupLocationMarker(_ coordinate: CLLocationCoordinate2D) {
        if locationMaker != nil {
            locationMaker.map = nil
        }
        locationMaker = GMSMarker(position: coordinate)
        locationMaker.map = mapView
        locationMaker.title = maptasks.fetchedFormattedAddress
        locationMaker.appearAnimation = GMSMarkerAnimation.pop
        locationMaker.icon =  UIImage(named: "taxi_icon")
        locationMaker.rotation = 242.0
        locationMaker.infoWindowAnchor = CGPoint(x: 0.8, y: 0.8)
    }
    
    //WYPopoveViewController
    @IBAction func open(_sender: Any) {
        self.showPopover(_sender: _sender)
    }
    
    func close(_sender: Any) {
        self.settingsPopoverController.dismissPopover(animated: true, options: WYPopoverAnimationOptions.fadeWithScale)
        self.settingsPopoverController.delegate = nil
        self.settingsPopoverController = nil
    }
    
    @IBAction func showPopover(_sender: Any) {
        
        if settingsPopoverController == nil {
            let btn: UIView = _sender as! UIView
            
            let settingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "WYSettingsViewController") as! WYSettingsViewController
            settingsViewController.preferredContentSize = CGSize(width: 375, height: 280)
            settingsViewController.isModalInPopover = false
            
            //var contentViewController = UINavigationController.init(rootViewController: settingsViewController)
            
            settingsPopoverController = WYPopoverController.init(contentViewController: settingsViewController)
            settingsPopoverController.delegate = self
            settingsPopoverController.passthroughViews = [btn]
            settingsPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 20, 10, 10)
            settingsPopoverController.wantsDefaultContentAppearance = false
            
            
            
            settingsPopoverController.presentPopover(from: btn.bounds, in: btn, permittedArrowDirections: WYPopoverArrowDirection.any, animated: true, options: WYPopoverAnimationOptions.fadeWithScale)
            
        }
        else {
            self.close(_sender: _sender)
        }
    }
    
}

extension AssetsScreenViewController: GMSMapViewDelegate {
    
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

extension AssetsScreenViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // Try to reuse the existing ‘pisa’ annotation image, if it exists.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "pisa")
        
        if annotationImage == nil {
            // Leaning Tower of Pisa by Stefan Spieler from the Noun Project.
            var image = UIImage(named: "taxi_icon")!
            
            // The anchor point of an annotation is currently always the center. To
            // shift the anchor point to the bottom of the annotation, the image
            // asset includes transparent bottom padding equal to the original image
            // height.
            //
            // To make this padding non-interactive, we create another image object
            // with a custom alignment rect that excludes the padding.
            image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
            
            // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "pisa")
        }
        
        return annotationImage
    }
   
    // Or, if you’re using Swift 3 in Xcode 8.0, be sure to add an underscore before the method parameters:
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
}

//WYPopoverController Delegate
extension AssetsScreenViewController: WYPopoverControllerDelegate {
    
    func popoverControllerDidPresentPopover(_ popoverController: WYPopoverController!) {
        print("popoverControllerDidPresentPopover")
    }
    
    func popoverControllerShouldDismissPopover(_ popoverController: WYPopoverController!) -> Bool {
        return true
    }
    
    func popoverControllerDidDismissPopover(_ popoverController: WYPopoverController!) {
        if popoverController == settingsPopoverController {
            settingsPopoverController.delegate = nil
            settingsPopoverController = nil
        }
    }
    
    func popoverControllerShouldIgnoreKeyboardBounds(_ popoverController: WYPopoverController!) -> Bool {
        return true
    }
    
    private func popoverController(_ popoverController: WYPopoverController, willTranslatePopoverWithYOffset value: Float) {
        // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
//        value = 0
        // set value to 0 if you want to avoid the popover to be moved
    }
}

extension AssetsScreenViewController: CLLocationManagerDelegate {
    
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
