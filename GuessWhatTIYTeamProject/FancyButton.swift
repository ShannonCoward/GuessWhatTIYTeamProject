//
//  FancyButton.swift
//  GuessWhatTIYTeamProject
//
//  Created by Shannon Armon on 6/18/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

@IBDesignable class FancyButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var buttonColor: UIColor = UIColor.clearColor()
    @IBInspectable var lineThickness: CGFloat = 0
   
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let insetRect = CGRectInset(rect, 10, 10)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        CGContextFillPath(context)
        let insetPath = UIBezierPath(roundedRect: insetRect, cornerRadius: cornerRadius)
        
        buttonColor.set()
        
        CGContextAddPath(context, path.CGPath)
        CGContextFillPath(context)
        

        CGContextAddPath(context, insetPath.CGPath)
        CGContextStrokePath(context)
        
    }
    
}
