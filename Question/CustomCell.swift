//
//  CustomTableViewCell.swift
//  Question
//
//  Created by 高橋詩穂 on 2016/03/19.
//  Copyright © 2016年 Shiho Takahashi. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var iconImageView: UIImageView!
    
    var nameLabel: UILabel!
    
    var titleLabel: UILabel!
    
    var textbodyLabel: UILabel!
    
    var subjectLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 205/255, alpha: 1)
        
        //icon
        iconImageView = UIImageView(frame: CGRect(x: 3, y: 3, width: 50, height: 50))
        self.addSubview(iconImageView)
        iconImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        //name
        nameLabel = UILabel(frame: CGRect(x: 65, y: 10, width: 100, height: 35))
        nameLabel.textColor = UIColor.brownColor()
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.backgroundColor = UIColor(red: 185/255, green: 255/255, blue: 140/255, alpha: 1)
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 5
        self.addSubview(nameLabel)
        
        //title
        titleLabel = UILabel(frame: CGRect(x: 50, y: 54, width: 300, height: 35))
        titleLabel.textColor = UIColor.brownColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor(red: 249/249, green: 192/249, blue: 79/249, alpha: 1)
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 5
        self.addSubview(titleLabel)
        
        //text
        textbodyLabel = UILabel(frame: CGRect(x: 50, y: 83, width: 300, height: 100))
        textbodyLabel.textColor = UIColor.blackColor()
        textbodyLabel.backgroundColor = UIColor(red: 249/249, green: 192/249, blue: 79/249, alpha: 1)
        textbodyLabel.layer.masksToBounds = true
        textbodyLabel.layer.cornerRadius = 5
        self.addSubview(textbodyLabel)
        
        //subject
        subjectLabel = UILabel(frame: CGRect(x: 290, y: 10, width: 60, height: 35))
        subjectLabel.textColor = UIColor.brownColor()
        subjectLabel.textAlignment = NSTextAlignment.Center
        subjectLabel.backgroundColor = UIColor(red: 249/249, green: 192/249, blue: 79/249, alpha: 1)
        subjectLabel.layer.masksToBounds = true
        subjectLabel.layer.cornerRadius = 5
        self.addSubview(subjectLabel)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
