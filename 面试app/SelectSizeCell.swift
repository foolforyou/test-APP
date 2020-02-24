//
//  SelectSizeCell.swift
//  面试app
//
//  Created by 陈思 on 2020/2/24.
//  Copyright © 2020 chance. All rights reserved.
//

import UIKit

class SelectSizeCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.blue
        label.layer.borderWidth = 1.0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
