//
//  PictureButton.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/18/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

@IBDesignable class PictureButton: UIButton {

   
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        var insetRect = CGRectInset(rect, 1, 1)
        
        UIColor.blackColor().set()
        
        CGContextSetLineWidth(context, 1)
        
        CGContextStrokeEllipseInRect(context, insetRect)
    }


}
