//
//  CommentViewConntroller.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/06/11.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import Firebase

class CommentViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var sendTextField: UITextField!
    var question: Question?
    var names = [""]
    var comments = [""]
    
    let saveData = NSUserDefaults.standardUserDefaults()
    
    
    @IBAction func send() {
        if sendTextField.text?.characters.count != 0 {
            let firebaseRef = FIRDatabase.database().reference()
            let uuid = NSUUID().UUIDString
            let name = saveData.objectForKey("name") as! String
            let comments = [uuid: [name: sendTextField.text!]]
            firebaseRef.child(question!.id).child("comment").updateChildValues(comments)
            
            let alert: UIAlertController = UIAlertController(title: "コメント", message: "送信が完了しました", preferredStyle:  UIAlertControllerStyle.Alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{
                (action: UIAlertAction!) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "エラー", message: "コメントが書かれていません", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default) { _ in}
            ac.addAction(okAction)
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.question = appDelegate.question
        if let comment = question!.comment {
            for (_, value) in comment {
                self.names.append(value.first!.0)
                self.comments.append(value.first!.1)
            }
        }
        
        table.dataSource = self
        table.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        table.registerClass(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        
        self.setNeedsStatusBarAppearanceUpdate();
        
        sendTextField.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillBeShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
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
        
        sendTextField.resignFirstResponder()
        
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // trueの場合はステータスバー非表示
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
            
            cell.iconImageView.image = UIImage(named: "iconきりん-1")
            cell.subjectLabel.text = question!.subject
            cell.titleLabel.text = question!.unit
            cell.textbodyLabel.text = question!.content
            cell.nameLabel.text = question!.name
            
            return cell
        } else {
            tableView.rowHeight = 135
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
            cell.iconImageView.image = UIImage(named: "iconきりん-1")
            cell.nameLabel.text = names[indexPath.row]
            cell.replyLabel.text = comments[indexPath.row]
            return cell
        }
    }
    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
        
//        question.removeAll()
//        let firebaseRef = FIRDatabase.database().reference()
//        firebaseRef.queryLimitedToLast(25).observeEventType(.ChildAdded, withBlock: { snapshot in
//            if let subject = snapshot.value!.objectForKey("subject") as? String,
//                unit = snapshot.value!.objectForKey("unit") as? String,
//                content = snapshot.value!.objectForKey("content") as? String,
//                comment = snapshot.value!.objectForKey("comment") as? [String: [String: String]] {
//                
//                let q = Question(id: snapshot.key, subject: subject, unit: unit, content: content, name: "Shiho", comment: comment)
//                self.question.insert(q, atIndex: 0)
//            }
//            self.table.reloadData()
//            self.refreshControl.endRefreshing()
//        })
    }
}
