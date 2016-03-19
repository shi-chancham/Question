//
//  ViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/03/05.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.dataSource = self
        table.delegate = self
        
        table.registerClass(CustomCell.self, forCellReuseIdentifier: "tableCell")
        
        table.rowHeight = 200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //datasourse
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! CustomCell
        
        cell.iconImageView.image = UIImage(named: "icon")
        cell.titleLabel.text = "test"
        cell.textbodyLabel.text = "question"
        cell.subjectLabel.text = "subject"
        
        return cell
    }
    
    //delegate
    //cellがタップされたとき呼ばれるメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    @IBAction func post() {
        
    }

}

