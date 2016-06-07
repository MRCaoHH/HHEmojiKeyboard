//
//  HHImageKeyboardCell.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/7.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHImageKeyboardCell: UICollectionViewCell {
    /// emoji表情标签
    var imgView:UIImageView!
    // MARK: - 父类方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initUI()
    }
    
    // MARK: - 初始化
    /**
     初始化UI
     */
    func initUI(){
        self.imgView = UIImageView()
        self.imgView.contentMode =  UIViewContentMode.Center
        self.imgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imgView)
        
        let vflH = "H:|-0-[imgView]-0-|"
        let vflV = "V:|-0-[imgView]-0-|"
        
        let hLayout =  NSLayoutConstraint.constraintsWithVisualFormat(vflH, options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["imgView" : self.imgView])
        let vLayout =  NSLayoutConstraint.constraintsWithVisualFormat(vflV, options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["imgView" : self.imgView])
        self.addConstraints(hLayout)
        self.addConstraints(vLayout)
    }

}
