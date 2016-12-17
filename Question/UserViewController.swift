//
//  LoginViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/08/06.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController, UITextFieldDelegate {
    
    let saveData = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        if saveData.objectForKey("name") as! String! != nil {
            
        }
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        mailTextField.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserViewController.keyboardWillBeShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillBeShown(notification: NSNotification) {
//        passwordTextField = UITextField(frame: CGRect(x: 50, y: 100, width: 300, height: 35))
        let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration:NSTimeInterval = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animateWithDuration(duration, animations: {
            let transform = CGAffineTransformMakeTranslation(0, -rect.size.height)
            self.view.transform = transform
            },completion:nil)
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
//        passwordTextField = UITextField(frame: CGRect(x: 50, y: 54, width: 300, height: 35))
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double)
        UIView.animateWithDuration(duration, animations:{
            self.view.transform = CGAffineTransformIdentity
            },completion:nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        mailTextField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func done() {
        
        if passwordTextField.text?.characters.count < 6 {
            print("パスワードエラー")
            let alert = UIAlertController(title: "error!", message: "6文字以上のパスワードにしてください", preferredStyle:  UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            _ = FIRDatabase.database().reference()
            
            FIRAuth.auth()?.createUserWithEmail(mailTextField.text!, password: passwordTextField.text!, completion: { (user:FIRUser?, error:NSError?) in
                if let error = error {
                    
                    let alert = UIAlertController(title: "error!", message: "有効なメールアドレスを入力してください", preferredStyle:  UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(defaultAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    print("エラー \(error)")
                    return
                }
                
                if let user = user {
                    print("user : \(user.email) has been created successfully.")
                }
                
                let secondViewController: UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as! UINavigationController
                self.presentViewController(secondViewController, animated: true, completion: nil)
                print("ここまでok")
            })
        }
        
    }
    
}

