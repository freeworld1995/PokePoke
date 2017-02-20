//
//  TriangleTransition.swift
//  CircularTransition
//
//  Created by Jimmy Hoang on 2/20/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class TriangleTransition: NSObject {
    var duration = 2.0
    var triangle = UIImageView(image: #imageLiteral(resourceName: "triangle2"))
    
    enum TriangleTransitionMode: Int {
        case present, dismiss
    }
    
    var transitionMode: TriangleTransitionMode = .present
}

extension TriangleTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let contrainer = transitionContext.containerView
        contrainer.backgroundColor = UIColor.red
        
        let presentedView = transitionContext.view(forKey: .to)!
        let returningView = transitionContext.view(forKey: .from)!
        
        if transitionMode == .present {
            let viewCenter = presentedView.center
            
            triangle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            triangle.center = viewCenter
            contrainer.addSubview(triangle)
            presentedView.center = viewCenter
            presentedView.mask = triangle
            //                presentedView.center = startingPoint
            //                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            contrainer.addSubview(presentedView)
            
            UIView.animate(withDuration: duration, animations: {
                self.triangle.transform = CGAffineTransform(scaleX: 10, y: 10)
                //                    presentedView.transform = .identity
                
            }, completion: { (success) in
                transitionContext.completeTransition(success)
            })
        } else {
            let viewCenter = returningView.center
            contrainer.addSubview(presentedView)
            contrainer.bringSubview(toFront: returningView)
            
            triangle.center = viewCenter
            returningView.mask = triangle
            
            UIView.animate(withDuration: duration, animations: {
                self.triangle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }, completion: { (success) in
                returningView.center = viewCenter
                returningView.removeFromSuperview()
                self.triangle.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
            
        }
    }
    
    func frameForTriangle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
