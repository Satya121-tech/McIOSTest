//
//  WebViewController.swift
//  IOSTest
//
//  Created by Satya on 10/08/19.
//  Copyright © 2019 Satya. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreDataHandler = ITDataBaseHandler()
        if let accessToken = coreDataHandler.getToken(){
            
            let urlString = ITConstant.WEBVIEW_API_URL + ITConstant.WEBVIEW_ACCESSTOKEN_KEY + accessToken
            if let url = URL(string: urlString){
                let request = URLRequest(url: url)
                
                activityIndicatorView.startAnimating()
                activityIndicatorView.isHidden = false
                webView.navigationDelegate = self
                webView.load(request)
            }
        }
    }
    
    //MARK: WK Navigation Delegate
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        webView.isHidden = false
        activityIndicatorView.isHidden = true
    }
}
