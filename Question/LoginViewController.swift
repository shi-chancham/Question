//
//  LoginViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/08/07.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ref = FIRDatabase.database().reference()
    
    @IBOutlet var exmailTextField: UITextField!
    @IBOutlet var expasswordTextField: UITextField!
    
    @IBAction func login() {
        FIRAuth.auth()?.signInWithEmail(exmailTextField.text!, password: expasswordTextField.text!, completion: { (user:FIRUser?, error:NSError?) in
            if let error = error {
                print("login failed! \(error)")
                return
            }
            
            if let user = user {
                print("user : \(user.email) has been signed in successfully.")
            }
        })
    }
    
}