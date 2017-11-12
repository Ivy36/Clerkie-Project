//
//  LoginVC.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/8.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var usrnameTextField: UITextField!
    
    @IBOutlet weak var passwdTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var userList: String = ""
    
    var data: NSDictionary = [:]
    
    @IBAction func loginAction(_ sender: UIButton) {
        checkCredential(currName: usrnameTextField.text, currPassword: passwdTextField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userList = Bundle.main.path(forResource: "DefaultUsers", ofType: "plist")!
        data = NSDictionary(contentsOfFile:userList) as! NSDictionary
    }
    
    func checkCredential(currName name: String?, currPassword password: String?) {
        if name == nil || name == "" {
            showAlert("Username cannot be empty.")
        } else if password == nil || password == "" {
            showAlert("Password cannot be empty.")
        } else {
            let user = data.object(forKey: name!) as? NSDictionary
            if user == nil {
                showAlert("This user does not exist!")
            } else {
                let realPassword = user!.object(forKey: "password") as! NSString
                if !realPassword.isEqual(to: password!) {
                    showAlert("Password is not correct!")
                } else {
                    UserDefaults.standard.set(user!.object(forKey: "username"), forKey: "currUsername")
                    UserDefaults.standard.set(realPassword, forKey: "currPassword")
                    UserDefaults.standard.set(user!.object(forKey: "screenName"), forKey: "currScreenName")
                    UserDefaults.standard.set(user!.object(forKey: "imageUrl"), forKey: "currImageUrl")
                    UserDefaults.standard.set(user!.object(forKey: "id"), forKey: "currID")
                    UserDefaults.standard.synchronize()
                    performSegue(withIdentifier: "showHome", sender: self)
                }
            }
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title:"", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

