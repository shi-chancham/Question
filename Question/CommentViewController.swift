//
//  CommentViewConntroller.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/06/11.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.question = appDelegate.question
        
        table.dataSource = self
     
        print(question)
        
        table.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        table.registerClass(CommentCell.self, forCellReuseIdentifier: "CommentCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
            
            cell.iconImageView.image = UIImage(named: "icon")
            cell.subjectLabel.text = question!.subject
            cell.titleLabel.text = question!.unit
            cell.textbodyLabel.text = question!.content

            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
            
            
            cell.textLabel?.text = "コメント"
            
            return cell

        }
        
    }
    
}
