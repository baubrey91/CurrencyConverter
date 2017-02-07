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
    
    
    //didnt finish
    class func serviceCall(urlString: String) {
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    let rates = parsedData["rates"] as? NSDictionary
                    rateDic = rates!
                    
                    
                } catch let error as NSError {
                    print(error)

                }
            }
            
            }.resume()
    }
}

