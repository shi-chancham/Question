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
    
    let ref = Firebase(url:"https://brilliant-fire-2087.firebaseIO.com")
    
    @IBOutlet var exmailTextField: UITextField!
    @IBOutlet var expasswordTextField: UITextField!
    
    @IBAction func login() {
        ref.authUser(exmailTextField.text, password: expasswordTextField.text,
                     withCompletionBlock: { error, authData in
                        if error != nil {
                            // There was an error logging in to this account
                        } else {
                            // We are now logged in
                        }
        })
    }
    
}