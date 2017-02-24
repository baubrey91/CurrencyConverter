//
//  Service.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation

class Service {
    
    static let sharedInstance = Service()
    
    
    func getJSON(_ url: String, completionHandler: @escaping ((_ json: AnyObject) -> Void)) {
        let nsURL = URL(string: url)!
        let session = URLSession.shared
        let task = session.dataTask(with: nsURL, completionHandler: { data, response, error -> Void in
            if error != nil{
                print("error")
            }
            if data != nil {
                let jsonData = (try! JSONSerialization.jsonObject( with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String:Any]
                completionHandler(jsonData as AnyObject)
            }
            session.invalidateAndCancel()
        })
        task.resume()
        
    }
}


