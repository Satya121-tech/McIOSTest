//
//  APIHandler.swift
//  IOSTest
//
//  Created by Satya on 10/08/19.
//  Copyright © 2019 Satya. All rights reserved.
//

import Foundation

class ITAPIHandler: NSObject {
    
    func loginAPI(_ email: String, _ password : String, _ completion: @escaping (NSDictionary?, Error?) -> ()) {
        
        let request = ITAPIRequest.loginRequest(email, password)
        self.apiCallStart(request, completion)
    }
    
    func apiCallStart(_ request : NSMutableURLRequest, _ completion: @escaping (NSDictionary?, Error?) -> ()) {
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
                completion(nil, error)
            } else {
                
                guard let data = data else { return }
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        completion(jsonResult, nil)
                    }
                } catch let error {
                    print("Unspecified Error: \(error)")
                    completion(nil, error)
                }
            }
        })
        
        dataTask.resume()
    }
    
    func encodeParameters(parameters: [String : String]) -> String {
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        return parameterArray.joined(separator: "&")
    }
    
    func percentEscapeString(_ string: String) -> String {
        
        return string
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
}
