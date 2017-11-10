//
//  loginVC.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/8.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit

class loginVC: UIViewController {
    @IBOutlet weak var usrnameTextField: UITextField!
    
    @IBOutlet weak var passwdTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func loginAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showHome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
