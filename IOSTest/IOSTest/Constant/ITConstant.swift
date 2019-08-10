//
//  ITConstant.swift
//  IOSTest
//
//  Created by Satya on 10/08/19.
//  Copyright © 2019 Satya. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    
    func type() -> String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        }
    }
}

struct ITConstant {
    
    //MARK: ================== API Constants ====================
    static let API_BASE_URL         = "https://reqres.in/api/"
    static let WEBVIEW_API_URL      = "https://mckinleyrice.com?"
    
    //MARK: ================== API Request Header ====================
    static let API_REQUEST_HEADER_VALUE_JASON    = "application/json"
    
    static let KEY_HEADER_CONTENT_TYPE           = "Content-Type"
    static let KEY_HEADER_CONTENT_LENGTH         = "Content-Length"
    static let KEY_HEADER_AUTHORIZATION          = "Authorization"
    
    
    //MARK: ================== API Methods ====================
    static let API_METHOD_LOGIN                    = "login"
    
    //Request Param Keys
    static let API_LOGIN_EMAIL_KEY                     = "email"
    static let API_LOGIN_PASSWORD_KEY                  = "password"
    
    static let WEBVIEW_ACCESSTOKEN_KEY                 = "token"
    static let TEST_WEBVIEW_ACCESSTOKEN_KEY            = "QpwL5tke4Pnpja7X4"
    
    //MARK: ================== Data Parser Constants ============
    
    //MARK: ================== Core Data Constants ============
    static let ENTITY_NAME                    = "Response"
    static let ATTRIBUTE_ACCESS_TOKEN_KEY     = "accesstoken"
    
    //MARK: ================== Segue Constants ============
    static let WEBVIEW_SEGUE                   = "webViewSegue"
    
}
