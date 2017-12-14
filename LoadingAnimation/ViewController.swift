//
//  ViewController.swift
//  LoadingAnimation
//
//  Created by AKIL KUMAR THOTA on 12/14/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var shape:CAShapeLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //track layer
        
        let trackLayer = CAShapeLayer()
        let centre = view.center
        let path = UIBezierPath(arcCenter: centre, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2*CGFloat.pi, clockwise: true)
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10.0
        trackLayer.fillColor =  UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        //shape layer
        shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = 10.0
        shape.strokeEnd = 0
        shape.fillColor =  UIColor.clear.cgColor
        view.layer.addSublayer(shape)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
    }
    
    @objc func viewTapped() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        shape.add(animation, forKey: "someAnimation")
        
    }

    

}

