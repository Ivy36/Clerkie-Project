//
//  LoginVC.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/8.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit

/* VC for login interface
 */
class LoginVC: UIViewController {
    @IBOutlet weak var usrnameTextField: UITextField!
    
    @IBOutlet weak var passwdTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var appIconImg: UIImageView!
    
    var userList: String = ""
    
    var data: NSDictionary = [:]
    
    @IBAction func loginAction(_ sender: UIButton) {
        checkCredential(currName: usrnameTextField.text, currPassword: passwdTextField.text)
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        //Redirect to RegisterVC
        performSegue(withIdentifier: "register", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get file path of DefaultUsers.plist
        userList = Bundle.main.path(forResource: "DefaultUsers", ofType: "plist")!
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Cover"))
        appIconImg.image = #imageLiteral(resourceName: "app icon2.png")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Retrieve data from plist
        data = NSDictionary(contentsOfFile:userList) as! NSDictionary
        print("login data = \(data)")
    }
    
    func checkCredential(currName name: String?, currPassword password: String?) {
        if name == nil || name == "" {
            showAlert("Username cannot be empty.")
        } else if password == nil || password == "" {
            showAlert("Password cannot be empty.")
        } else {
            //Search for user input
            let user = data.object(forKey: name!) as? NSDictionary
            if user == nil {
                showAlert("This user does not exist!")
            } else {
                let realPassword = user!.object(forKey: "password") as! NSString
                if !realPassword.isEqual(to: password!) {
                    showAlert("Password is not correct!")
                } else {
                    //Store user info locally
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
    
    //Set alert pop-up window
    func showAlert(_ message: String) {
        let alert = UIAlertController(title:"", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

