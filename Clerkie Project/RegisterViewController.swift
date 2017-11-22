//
//  RegisterViewController.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit

/* VC for register interface
 */
class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var PasswordTextFiel: UITextField!
    
    @IBOutlet weak var screenNameTextField: UITextField!
    
    @IBOutlet weak var appIconImg: UIImageView!
    
    var userList: String = ""
    
    var data: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Cover"))
        appIconImg.image = #imageLiteral(resourceName: "app icon2")
        //Get file path of DefaultUsers.plist and retrieve data
        userList = Bundle.main.path(forResource: "DefaultUsers", ofType: "plist")!
        data = NSMutableDictionary(contentsOfFile:userList) as! NSDictionary
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //unwind segue
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func registerAction(_ sender: UIButton) {
        checkRegisterInfo()
    }
    
    func checkRegisterInfo() {
        let name = usernameTextField.text
        let password = PasswordTextFiel.text
        let screenName = screenNameTextField.text
        if name == nil || name == "" {
            showAlert("Username cannot be empty.")
        } else if password == nil || password == "" {
            showAlert("Password cannot be empty.")
        } else if screenName == nil || screenName == ""{
            showAlert("Screen Name cannot be empry.")
        }else {
            //check whether username is a valid email address/ phone number
            let mailPattern =
            "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            let mailMatcher = RegexHelper(mailPattern)
            let numPattern = "^[0-9]{10}$"
            let numMatcher = RegexHelper(numPattern)
            if !mailMatcher.match(input: name!) && !numMatcher.match(input: name!) {
                showAlert("Username is Invalid.")
            } else {
                let user = data.object(forKey: name!) as? NSDictionary
                if user != nil {
                    showAlert("This user has already existed!")
                } else {
                    //Create a new user object
                    let cnt = data.count
                    let newUser: NSDictionary = ["username": name!, "password" : password!, "screenName" : screenName!, "imageUrl" : "https://images.unsplash.com/photo-1477276266798-898214c677da?ixlib=rb-0.3.5&q=85&fm=jpg&crop=entropy&cs=srgb&dl=cristian-newman-153712.jpg&s=3f59c16cde17f17e3b65cecf02fd4d4a", "id": String(cnt)]
                    
                    //Write into plist and save
                    data.setValue(newUser, forKey: name!)
                    data.write(toFile: userList, atomically: true)
                    let newData = NSMutableDictionary(contentsOfFile:userList) as! NSDictionary
                    print("newData = \(newData)")
                    
                    //Save local user info
                    UserDefaults.standard.set(name!, forKey: "currUsername")
                    UserDefaults.standard.set(password!, forKey: "currPassword")
                    UserDefaults.standard.set(screenName!, forKey: "currScreenName")
                    UserDefaults.standard.set("https://images.unsplash.com/photo-1477276266798-898214c677da?ixlib=rb-0.3.5&q=85&fm=jpg&crop=entropy&cs=srgb&dl=cristian-newman-153712.jpg&s=3f59c16cde17f17e3b65cecf02fd4d4a", forKey: "currImageUrl")
                    UserDefaults.standard.set(String(cnt), forKey: "currID")
                    UserDefaults.standard.synchronize()
                    performSegue(withIdentifier: "registerOK", sender: self)
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
