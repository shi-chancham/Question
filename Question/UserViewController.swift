//
//  LoginViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/08/06.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController {
    
    let saveData = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        if saveData.objectForKey("name") as! String! != nil {
            
        }
    }
    
    @IBAction func done() {
        
        _ = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.createUserWithEmail(mailTextField.text!, password: passwordTextField.text!, completion: { (user:FIRUser?, error:NSError?) in
            if let error = error {
                print("Creating the user failed! \(error)")
                return
            }
            
            if let user = user {
                print("user : \(user.email) has been created successfully.")
            }
        })
        
    }
    
}

