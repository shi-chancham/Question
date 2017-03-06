//
//  PrivacyViewController.swift
//  Question
//
//  Created by 高橋詩穂 on 2017/02/25.
//  Copyright © 2017年 Shiho Takahashi. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("privacy", ofType: "html")
        let url = NSURL(string: path!)
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
    }
    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // trueの場合はステータスバー非表示
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
