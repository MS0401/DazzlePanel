//
//  AssetsViewController.swift
//  DazzlePanel
//
//  Created by For on 5/24/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import PopupController

class AssetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var informations: [AssetsInformation] = [AssetsInformation]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchBar initialize///
        
        for subView in searchBar.subviews {
            for view in subView.subviews {
                if view.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                    let imageView = view as! UIImageView
                    imageView.layer.cornerRadius = 10
                }
            }
        }
        
        self.searchView.layer.cornerRadius = 10
        self.searchView.layer.borderWidth = 1
        self.searchView.layer.borderColor = UIColor.white.cgColor
        
        self.searchBar.placeholder = self.setPlaceHolder(placeholder: "Search Assets")
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        textFieldInsideSearchBar?.backgroundColor = UIColor.init(netHex: 0xF5F5F5)
        textFieldInsideSearchBar?.font = UIFont(name: "Helvetica", size: 22.0)
        textFieldInsideSearchBar?.leftViewMode = UITextFieldViewMode.never
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffsetMake(0, 0)
        
        
        
        
        let type = "APY-041"
        let describe = "Ford Transit 16"
        let name = "JOHN EBEJER"
        let address = "Cirkewwa, Mellieha, Malta"
        let time = "2 hours"
        let distance = "37156 km"
        let imageName = "status1"
        
        let TempInformation: NSDictionary = ["type": type, "describe": describe, "name": name, "address": address, "time": time, "distance": distance, "imageName": imageName] as NSDictionary
        let information: AssetsInformation = AssetsInformation.init(dictionary: TempInformation)
        informations.append(information)
        
        let type1 = "APY-041"
        let describe1 = "Ford Transit 16"
        let name1 = "MAXIM NELISON"
        let address1 = "Selmun, Mellieha, Malta"
        let time1 = "8 hours"
        let distance1 = "20354 km"
        let imageName1 = "status2"
        
        let TempInformation1: NSDictionary = ["type": type1, "describe": describe1, "name": name1, "address": address1, "time": time1, "distance": distance1, "imageName": imageName1] as NSDictionary
        let information1: AssetsInformation = AssetsInformation.init(dictionary: TempInformation1)
        informations.append(information1)
        
        let type2 = "BLY-016"
        let describe2 = "Volkswagen Transporter"
        let name2 = "KAN WISBERG"
        let address2 = "Main Road, Mellieha, Malta"
        let time2 = "9 hours"
        let distance2 = "12596 km"
        let imageName2 = "status3"
        
        let TempInformation2 : NSDictionary = ["type": type2, "describe": describe2, "name": name2, "address": address2, "time": time2, "distance": distance2, "imageName": imageName2] as NSDictionary
        let information2: AssetsInformation = AssetsInformation.init(dictionary: TempInformation2)
        informations.append(information2)

        // Do any additional setup after loading the view.
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
    override func viewWillDisappear(_ animated: Bool) {
        // Set back bar item
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func ShowPopover(_ sender: Any) {
        
        PopupController
            .create(self)
            .customize(
                [
                    .animation(.slideUp),
                    .scrollable(false),
                    .backgroundStyle(.blackFilter(alpha: 0.7))
                ]
            )
            .didShowHandler { popup in
                print("showed popup!")
            }
            .didCloseHandler { _ in
                print("closed popup!")
            }
            .show(DemoPopupViewController2.instance())
    }
    
    //tableview datasource delegate.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assets", for: indexPath) as! AssetsViewCell
        
        cell.assetsType.text = informations[indexPath.row].assetsType
        print(cell.assetsType.text!)
        cell.assetsDescribe.text = informations[indexPath.row].assetsDescribe
        print(cell.assetsDescribe.text!)
        cell.assetsName.text = informations[indexPath.row].assetsName
        print(cell.assetsName.text!)
        cell.assetsAddress.text = informations[indexPath.row].assetsAddress
        print(cell.assetsAddress.text!)
        cell.requestTime.text = informations[indexPath.row].requestTime
        print(cell.requestTime.text!)
        cell.runningDistance.text = informations[indexPath.row].runningDistance
        print(cell.runningDistance.text!)
        cell.runningStateImage.image = informations[indexPath.row].runningStateImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
}

extension UISearchBar {
    func addFontSizeSearchBar(targetSearchBar:UISearchBar?) -> UISearchBar
    {
        let textFieldInsideSearchBar = targetSearchBar!.value(forKey: "searchField") as! UITextField
        textFieldInsideSearchBar.font = UIFont(name: "Helvetica", size: 20.0)
        textFieldInsideSearchBar.backgroundColor = UIColor.white
        
        return targetSearchBar!
    }
}

