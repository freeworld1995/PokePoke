//
//  CustomView.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/18/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5
    }

}
