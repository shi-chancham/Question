//
//  ViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/03/05.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit
import Firebase
//import PullToBounce

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    
    var refreshControl:UIRefreshControl!
    
    var question: [Question] = []
    
    var snap: FIRDataSnapshot!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setNeedsStatusBarAppearanceUpdate();
        
        table.dataSource = self
        table.delegate = self
        
        table.registerClass(CustomCell.self, forCellReuseIdentifier: "tableCell")
        
        table.rowHeight = 200
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "loading…")
        self.refreshControl.addTarget(self, action: #selector(ViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.table.addSubview(refreshControl)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        var CommentViewConrtoller = segue.destinationViewController as! CommentViewController
//        CommentViewController.Question = ViewController.Question
//    }
    
    override func prefersStatusBarHidden() -> Bool {
        // trueの場合はステータスバー非表示
        return true;
    }
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
    //datasourse
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! CustomCell
        
        cell.iconImageView.image = UIImage(named: "iconきりん-1")
        cell.nameLabel.text = question[indexPath.row].name
        cell.subjectLabel.text = question[indexPath.row].subject
        cell.titleLabel.text = question[indexPath.row].unit
        cell.textbodyLabel.text = question[indexPath.row].content
        cell.selectionStyle = .None
        cell.reportButton.tag = indexPath.row
        cell.reportButton.addTarget(self, action: #selector(ViewController.report), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    //delegate
    //cellがタップされたとき呼ばれるメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.question = question[indexPath.row]
        
        let pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CommentViewController") as! CommentViewController
        self.presentViewController(pageViewController, animated: true, completion: nil)
    }
    
    @IBAction func post() {
        
    }
    
    func refresh() {
        question.removeAll()
        let firebaseRef = FIRDatabase.database().reference()
        firebaseRef.queryLimitedToLast(25).observeEventType(.ChildAdded, withBlock: { snapshot in
            if let subject = snapshot.value!.objectForKey("subject") as? String,
                let unit = snapshot.value!.objectForKey("unit") as? String,
                content = snapshot.value!.objectForKey("content") as? String, name = snapshot.value!.objectForKey("name") as? String {
                
                let comment = snapshot.value!.objectForKey("comment") as? [String: [String: String]]
                let q = Question(id: snapshot.key, subject: subject, unit: unit, content: content, name: name, comment: comment)
                self.question.insert(q, atIndex: 0)
            }
            self.table.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            self.delete(deleteIndexPath: indexPath)
            question.removeAtIndex(indexPath.row)
            table.reloadData()
        }
    }
    
    func delete(deleteIndexPath indexPath: NSIndexPath) {
        let ref = FIRDatabase.database().reference()
        ref.child(question[indexPath.row].id).removeValue()
    }
    
    @IBAction func logout() {
        do {
            //do-try-catchの中で、FIRAuth.auth()?.signOut()を呼ぶだけで、ログアウトが完了
            try FIRAuth.auth()?.signOut()
            //先頭のNavigationControllerに遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Nav")
            self.presentViewController(storyboard, animated: true, completion: nil)
        }catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    func report(sender: UIButton) {
        let alert = UIAlertController(title: "", message: "", preferredStyle:  UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel) { _ in
            print("cancel")
        }
        
        let destructiveAction_1: UIAlertAction = UIAlertAction(title: "報告する", style: UIAlertActionStyle.Destructive) { _ in
            let okAlert = UIAlertController(title: "投稿を報告しました。", message: "", preferredStyle:  UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "閉じる", style: UIAlertActionStyle.Default, handler: nil)
            okAlert.addAction(action)
            self.presentViewController(okAlert, animated: true, completion: nil)
        }
        
        let destructiveAction_2: UIAlertAction = UIAlertAction(title: "ブロックする", style: UIAlertActionStyle.Destructive) { _ in
            let firebaseRef = FIRDatabase.database().reference()
            
            firebaseRef.child(self.question[sender.tag].id).removeValue()
            let okAlert = UIAlertController(title: "ユーザーをブロックしました。", message: "", preferredStyle:  UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "閉じる", style: UIAlertActionStyle.Default, handler: nil)
            okAlert.addAction(action)
            self.presentViewController(okAlert, animated: true, completion: nil)
        }
        
        alert.addAction(destructiveAction_1)
        alert.addAction(destructiveAction_2)
        alert.addAction(cancelAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
