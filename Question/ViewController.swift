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
        cell.subjectLabel.text = question[indexPath.row].subject
        cell.titleLabel.text = question[indexPath.row].unit
        cell.textbodyLabel.text = question[indexPath.row].content
        cell.selectionStyle = .None
        
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
                unit = snapshot.value!.objectForKey("unit") as? String,
                content = snapshot.value!.objectForKey("content") as? String,
                comment = snapshot.value!.objectForKey("comment") as? [String: [String: String]] {
                
                let q = Question(id: snapshot.key, subject: subject, unit: unit, content: content, name: "Shiho", comment: comment)
                self.question.append(q)
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
    
}
