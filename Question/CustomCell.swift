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
    
    var reportButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 205/255, alpha: 1)
        
        self.selectionStyle = .None
        
        let cellWidth = UIScreen.mainScreen().bounds.size.width
        
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
        titleLabel = UILabel(frame: CGRect(x: cellWidth*0.1, y: 54, width: cellWidth*0.85, height: 35))
        titleLabel.textColor = UIColor.brownColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor(red: 249/249, green: 192/249, blue: 79/249, alpha: 1)
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 5
        self.addSubview(titleLabel)
        
        //text
        textbodyLabel = UILabel(frame: CGRect(x: cellWidth*0.1 , y: 83, width: cellWidth*0.85, height: 100))
        textbodyLabel.textColor = UIColor.blackColor()
        textbodyLabel.backgroundColor = UIColor(red: 249/249, green: 192/249, blue: 79/249, alpha: 1)
        textbodyLabel.layer.masksToBounds = true
        textbodyLabel.layer.cornerRadius = 5
        textbodyLabel.font = UIFont.systemFontOfSize(14);
        textbodyLabel.numberOfLines = 4
        self.addSubview(textbodyLabel)
        
        //subject
        subjectLabel = UILabel(frame: CGRect(x: cellWidth*0.79, y: 53.8, width: 60, height: 35))
        subjectLabel.textColor = UIColor.brownColor()
        subjectLabel.textAlignment = NSTextAlignment.Center
        subjectLabel.backgroundColor = UIColor(red: 249/249, green: 192/249, blue: 79/249, alpha: 1)
        subjectLabel.layer.masksToBounds = true
        subjectLabel.layer.cornerRadius = 5
        self.addSubview(subjectLabel)
        
        //report
        reportButton = UIButton(frame:  CGRect(x: cellWidth*0.86, y: 16, width: 30, height: 30))
        reportButton.setTitle("…", forState: UIControlState.Normal)
        reportButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        self.addSubview(reportButton)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
