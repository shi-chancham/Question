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

    let ref = Firebase(url:"https://brilliant-fire-2087.firebaseIO.com")
    let saveData = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        if saveData.objectForKey("name") as! String! != nil {
            
        }
    }
    
    @IBAction func done() {
        
        ref.createUser(mailTextField.text, password: passwordTextField.text,
                       withValueCompletionBlock: { error, result in
                        if error != nil {
                            // There was an error creating the account
                        } else {
                            let uid = result["uid"] as? String
                            print("Successfully created user account with uid: \(uid)")
                            
                            self.saveData.setObject(self.usernameTextField.text, forKey: "name")
                            self.saveData.setObject(self.mailTextField.text, forKey: "mail")
                            self.saveData.setObject(self.passwordTextField.text, forKey: "password")
                            self.saveData.synchronize()
                        }
        })
        
    }
    
}

