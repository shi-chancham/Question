//
//  CommentCell.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/06/25.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    var iconImageView: UIImageView!
    
    var nameLabel: UILabel!
    
    var replyLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 205/255, alpha: 1)
        
        //icon
        iconImageView = UIImageView(frame: CGRect(x: 3, y: 3, width: 30, height: 30))
        self.addSubview(iconImageView)
        
        //name
        nameLabel = UILabel(frame: CGRect(x: 45, y: 10, width: 90, height: 30))
        nameLabel.textColor = UIColor.brownColor()
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 5
        self.addSubview(nameLabel)

        //reply
        replyLabel = UILabel(frame: CGRect(x: 35, y: 83, width: 300, height: 90))
        replyLabel.textColor = UIColor.blackColor()
        replyLabel.layer.masksToBounds = true
        replyLabel.layer.cornerRadius = 5
        self.addSubview(replyLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
