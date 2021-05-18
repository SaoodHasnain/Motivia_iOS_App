//
//  CircleImage.swift
//  smack
//
//  Created by Hamza Shahbaz on 28/08/2018.
//  Copyright © 2018 Hamza Shahbaz. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }
    func setUpView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

}
