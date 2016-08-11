//
//  PostViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/03/19.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

//
//  ViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/03/05.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var subjectPickerview: UIPickerView!
    @IBOutlet var unitTextField: UITextField!
    @IBOutlet var mainTextView: UITextView!

    var subjectArray: NSArray = ["英語","国語","数学","社会","理科"]
    
    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var subject = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectPickerview.delegate = self
        subjectPickerview.dataSource = self
        unitTextField.delegate = self
        
    }
    
    @IBAction func post() {
        
        let firebaseRef = FIRDatabase.database().reference()
        
        if subjectPickerview == nil || unitTextField == nil || mainTextView == nil {
            //  alert
            let alert = UIAlertController(title: "error",
                                          message: "全ての項目を埋めてください",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: {action in
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                )
            )
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
            let messageData = ["name": saveData.objectForKey("name") as! String!, "subject": subject, "unit": unitTextField.text!, "content": mainTextView.text!, "comment": ["first": ["aura": "こめんと"]]]
            firebaseRef.childByAutoId().setValue(messageData)
        }
    }
    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: picker
    //表示列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //表示個数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjectArray.count
    }
    
    //表示内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjectArray[row] as? String
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subject = subjectArray[row] as! String
    }
    
    //MARK: textField
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if mainTextView.isFirstResponder() {
            mainTextView.resignFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
