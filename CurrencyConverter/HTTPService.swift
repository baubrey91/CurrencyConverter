//
//  HTTPService.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

class HttpService {
    
    class func getJSON(_ url: String) {
        let nsURL = URL(string: url)!
        let session = URLSession.shared
        let task = session.dataTask(with: nsURL, completionHandler: { data, response, error -> Void in
            
            if error != nil{
                print("error")
            }
            
            if data != nil {
                let jsonData = (try! JSONSerialization.jsonObject( with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String:Any]
                let rates = jsonData["rates"] as? NSDictionary
                rateDic = rates!
            }
            
            session.invalidateAndCancel()
            
        })
        task.resume()
    }
}


