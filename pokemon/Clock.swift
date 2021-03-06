//
//  Clock.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/18/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class Clock: UIView {
    
    var arcRadius: CGFloat = 25.0 { didSet {setNeedsDisplay()} }
    var arcDegree: Double = -90.0 { didSet {setNeedsDisplay()} }
    var lineWidth: CGFloat = 1.0
    var timer: Timer!
    var second: TimeInterval = 1
    
    func drawArc() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let path2 = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
        path2.addLine(to: center)
        path2.close()
        UIColor.white.setFill()
        path2.fill()
        
        let path = UIBezierPath(arcCenter: center, radius: arcRadius, startAngle: CGFloat((arcDegree).degreesToRadians), endAngle: CGFloat((270).degreesToRadians), clockwise: true)
        path.addLine(to: center)
        path.close()
        UIColor.gray.setFill()
        path.fill()
        setNeedsDisplay()
    }
    
    func degreeIncrement() {
        guard arcDegree < 360 else {
            timer.invalidate()
            return
        }
        
        arcDegree += 6
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        timer = Timer.scheduledTimer(timeInterval: second, target: self, selector: #selector(degreeIncrement), userInfo: nil, repeats: true)
    }
    
    override func draw(_ rect: CGRect) {
        drawArc()
    }
}
