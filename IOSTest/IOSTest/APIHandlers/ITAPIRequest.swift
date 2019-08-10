//
//  ITAPIRequest.swift
//  IOSTest
//
//  Created by Satya on 10/08/19.
//  Copyright © 2019 Satya. All rights reserved.
//

import Foundation

class ITAPIRequest: NSMutableURLRequest {
    
    /**
     *  @method request:
     *
     *  @param methodNameWithValueParam this will be concanate of methos name and its value
     *
     *  @discussion   Return custom NSMutableURLRequest.s
     *
     */
    class func loginRequest(_ email : String, _ password : String) -> NSMutableURLRequest {
        
        let parameters = [
            ITConstant.API_LOGIN_EMAIL_KEY: email,
            ITConstant.API_LOGIN_PASSWORD_KEY: password
            ] as [String : Any]
        
        var urlString = ITConstant.API_BASE_URL + ITConstant.API_METHOD_LOGIN
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return self.getRequest(urlString, parameters as NSDictionary)
    }
    
    private class func getRequest(_ urlString : String, _ parameters : NSDictionary) -> NSMutableURLRequest {
        
        let headers = [ITConstant.KEY_HEADER_CONTENT_TYPE: ITConstant.API_REQUEST_HEADER_VALUE_JASON]
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let request = NSMutableURLRequest(url: NSURL(string:url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HTTPMethod.type(HTTPMethod.post)()
        request.allHTTPHeaderFields = headers
        
        do{
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = postData
        }catch{
            print("request jason error")
        }
        
        return request
    }
}
