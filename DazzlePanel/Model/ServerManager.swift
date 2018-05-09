//
//  ServerManager.swift
//  Tektiles
//
//  Created by DEV on 4/18/17.
//  Copyright © 2017 Dima. All rights reserved.
//

import Foundation

class ServerManager: NSObject {
    
    // Base URL
    let baseUrl = "https://dev.tektiles.com/api/services/app/"
    
    // Data from server
    var items: NSArray!
    
    var item: NSDictionary!
    
    var userToken: String!
    
    override init() {
        super.init()
    }
    
    // Send Login Request
    func loginRequest(_ parameters: NSDictionary!, withCompletionHandler completionHandler: @escaping ((_ success: Bool) -> Void)) {
        
        // Create URL request
        let request = NSMutableURLRequest(url: URL(string: "https://dev.tektiles.com/api/account/authenticate")!)
        let session = URLSession.shared
        
        // Set request HTTP method to POST
        request.httpMethod = "POST"
        
        // Set request body
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            
            print("error => \(error)")
            return
        }
        
        // Set request Header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Excute HTTP Request
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
                print("error => \(String(describing: error))")
                return
                
            } else {
                
                //                print("response => \(response!)")
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    print("JSON => \(String(describing: json))")
                    if json != nil {
                        
                        // Check your account
                        let status = json!["success"] as! CFBoolean
                        print("status => \(status)")
                        
                        if status as Bool {
                            self.userToken = json!["result"] as! String
                            completionHandler(true)
                        } else {
                            completionHandler(false)
                        }
                    }
                } catch {
                    print("error => \(error)")
                    
                }
            }
        })
        
        dataTask.resume()
        
    }
    
    // Send Set Request
    func createSetRequest(_ childUrl: String!, parameters: NSDictionary!, withCompletionHandler completionHandler: @escaping ((_ success: Bool) -> Void)) {
        
        let urlString = baseUrl + childUrl
        
        // Create URL request
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        // Set request HTTP method to POST
        request.httpMethod = "POST"
        
        
        // Set request body
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            
            print("error => \(error)")
            return
        }
        
        // Set request Header
        request.addValue("Bearer \(SharedManager.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Excute HTTP Request
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
                print("error => \(String(describing: error))")
                return
                
            } else {
              
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    print("JSON => \(String(describing: json))")
                    if json != nil {
                        
                        let status = json!["success"] as! CFBoolean
                        print("status => \(status)")
                        if status as Bool {
                            completionHandler(true)
                            
                        } else {
                            completionHandler(false)
                        }
                    }
                } catch {
                    print("error => \(error)")
                    
                }
            }
        })
        
        dataTask.resume()
    }
    
    
    // Send Get Request
    func createGetRequest(_ childUrl: String!, withCompletionHandler completionHandler: @escaping ((_ success: Bool) -> Void)) {
        
//        let urlString = baseUrl + childUrl
//        
//        // Create URL request
//        let request = NSMutableURLRequest(url: URL(string: urlString)!)
//        let session = URLSession.shared
//        
//        // Set request HTTP method to POST
//        request.httpMethod = "POST"
//                
//        // Set request Header
//        request.addValue("Bearer \(SharedManager.sharedInstance.token)", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        // Excute HTTP Request
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                
//                print("error => \(String(describing: error))")
//                return
//                
//            } else {
//                
//                do {
//                    
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//                    
//                    print("JSON => \(String(describing: json))")
//                    if json != nil {
//                        
//                        let status = json!["success"] as! CFBoolean
//                        print("status => \(status)")
//                        if status as Bool {
//                            
//                            self.items = (json!["result"] as! NSDictionary)["items"] as! NSArray
//                            completionHandler(true)
//                            
//                        } else {
//                            completionHandler(false)
//                        }
//                    }
//                } catch {
//                    print("error => \(error)")
//                    
//                }
//            }
//        })
//        
//        dataTask.resume()
    }
    
    // Send Get Request for ticket
    func createGetRequestForItem(_ childUrl: String!, withCompletionHandler completionHandler: @escaping ((_ success: Bool) -> Void)) {
        
        let urlString = baseUrl + childUrl
        
        // Create URL request
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        // Set request HTTP method to POST
        request.httpMethod = "POST"
        
        // Set request Header
        request.addValue("Bearer \(SharedManager.sharedInstance.token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Excute HTTP Request
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
                print("error => \(String(describing: error))")
                return
                
            } else {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    print("JSON => \(String(describing: json))")
                    if json != nil {
                        
                        let status = json!["success"] as! CFBoolean
                        print("status => \(status)")
                        if status as Bool {
                            
                            self.item = json!["result"] as! NSDictionary
                            completionHandler(true)
                            
                        } else {
                            completionHandler(false)
                        }
                    }
                } catch {
                    print("error => \(error)")
                    
                }
            }
        })
        
        dataTask.resume()
    }
    
}
