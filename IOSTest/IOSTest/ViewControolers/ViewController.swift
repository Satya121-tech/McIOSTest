//
//  ViewController.swift
//  IOSTest
//
//  Created by Satya on 10/08/19.
//  Copyright © 2019 Satya. All rights reserved.
//

import UIKit

enum AppRunningMode {
    case Debug
    case Release
}

class ViewController: UIViewController {

    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        guard let email = txtEmailId.text else{return}
        guard let password = txtPassword.text else{return}
        
        //--- Debug Mode
        self.login(email, password, appRunningMode: .Debug)
        
        //--- Release Mode
        //self.login(email, password, appRunningMode: .Release)
    
    }
    
    func login(_ email: String, _ password : String, appRunningMode : AppRunningMode) -> Void {
        
        let apiHandle = ITAPIHandler()
        apiHandle.loginAPI(email, password) { (result, error) in
            print(result as Any)
            
            if appRunningMode == .Release{
                
                if let resultDict = result{
                    if let accessToken = resultDict.value(forKey: ""){
                        let coreDataHandler = ITDataBaseHandler()
                        coreDataHandler.saveToken(accessToken as! String)
                        
                        //--- Load next acreen after saving data into core databade ---
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.performSegue(withIdentifier: ITConstant.WEBVIEW_SEGUE, sender: nil)
                        }
                    }
                }
            }else{
                let coreDataHandler = ITDataBaseHandler()
                coreDataHandler.saveToken(ITConstant.TEST_WEBVIEW_ACCESSTOKEN_KEY)
                //--- Load next acreen after saving data into core databade ---
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.performSegue(withIdentifier: ITConstant.WEBVIEW_SEGUE, sender: nil)
                }
            }
        }

    }
}

