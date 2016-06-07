//
//  HHEmojiKeyboardCell.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHEmojiKeyboardCell: UICollectionViewCell {
    /// emoji表情标签
    var emojiLabel:UILabel!
    
    // MARK: - 父类方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        self.initUI()
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
        let size = self.frame.size
        self.emojiLabel.font = UIFont.systemFontOfSize(size.width/2)
    }

    // MARK: - 初始化
    /**
     初始化UI
     */
    func initUI(){
        self.emojiLabel = UILabel()
        self.emojiLabel.textAlignment = .Center
        self.emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emojiLabel)
        
        let vflH = "H:|-0-[emojiLabel]-0-|"
        let vflV = "V:|-0-[emojiLabel]-0-|"
        
        let hLayout =  NSLayoutConstraint.constraintsWithVisualFormat(vflH, options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["emojiLabel" : self.emojiLabel])
        let vLayout =  NSLayoutConstraint.constraintsWithVisualFormat(vflV, options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["emojiLabel" : self.emojiLabel])
        self.addConstraints(hLayout)
        self.addConstraints(vLayout)
    }
    
}
