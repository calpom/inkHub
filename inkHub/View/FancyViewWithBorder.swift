//
//  FancyViewWithBorder.swift
//  inkHub
//
//  Created by Kaleb  on 11/16/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit

class FancyViewWithBorder: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderWidth = 0.3
        layer.borderColor = UIColor.darkGray.cgColor
        
    }

}
