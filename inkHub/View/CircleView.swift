//
//  CircleView.swift
//  inkHub
//
//  Created by Kaleb  on 11/17/18.
//  Copyright © 2018 KMTech. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
