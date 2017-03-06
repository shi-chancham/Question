//
//  LoginViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/08/07.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet var exmailTextField: UITextField!
    @IBOutlet var expasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exmailTextField.delegate = self
        expasswordTextField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        //すでにログインされてたら
//        if FIRAuth.auth()?.currentUser != nil {
//            let secondViewController: UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as! UINavigationController
//            self.presentViewController(secondViewController, animated: false, completion: nil)
//        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // trueの場合はステータスバー非表示
        return true;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        exmailTextField.resignFirstResponder()
        expasswordTextField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func login() {
        _ = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.signInWithEmail(exmailTextField.text!, password: expasswordTextField.text!, completion: { (user:FIRUser?, error:NSError?) in
            if let error = error {
                print("login failed! \(error)")
                return
            }
            
            if let user = user {
                print("user : \(user.email) has been signed in successfully.")
            }
            
            let secondViewController: UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as! UINavigationController
            self.presentViewController(secondViewController, animated: true, completion: nil)
        })
    }
    
}
