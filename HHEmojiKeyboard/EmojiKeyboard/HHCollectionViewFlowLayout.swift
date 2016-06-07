//
//  HHCollectionViewFlowLayout.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/7.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        if let attributes = super.layoutAttributesForElementsInRect(rect){
            let attArr = NSArray(array: attributes, copyItems: true) as! [UICollectionViewLayoutAttributes]
            for att in attArr {
                let size = att.size
                let x = CGFloat(att.indexPath.row%Int(HHEmojiKeyboard_Column))*size.width+CGFloat(att.indexPath.section) * self.collectionView!.frame.size.width
                let y = CGFloat(att.indexPath.row/Int(HHEmojiKeyboard_Column))*size.height
                att.frame.origin.x = x
                att.frame.origin.y = y
            }
            return attArr
        }
        
        return nil
    }
}
