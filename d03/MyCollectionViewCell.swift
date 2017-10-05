//
//  MyCollectionViewCell.swift
//  d03
//
//  Created by Martin SIREAU on 05/10/2017.
//  Copyright © 2017 Martin SIREAU. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinningWheel: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        self.spinningWheel.hidesWhenStopped = true
        self.spinningWheel.color = .white
    }
}
