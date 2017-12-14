//
//  ViewController.swift
//  LoadingAnimation
//
//  Created by AKIL KUMAR THOTA on 12/14/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,URLSessionDownloadDelegate {
    
    
    
    let urlString = "https://static.pexels.com/photos/699796/pexels-photo-699796.jpeg"
    
    var shape:CAShapeLayer!
    
    let percentageLabel :UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.red
        return label
    }()
    
    let completionLabel:UILabel =  {
        let label = UILabel()
        label.text = "Completed"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //completionLabel
        view.addSubview(completionLabel)
        completionLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        completionLabel.center = CGPoint(x: view.center.x, y: view.center.y + 30)
        
        // percentageLabel Configuration
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        
        //track layer
        let trackLayer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        path.lineCapStyle = .round
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 20.0
        trackLayer.fillColor =  UIColor.clear.cgColor
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
        
        //shape layer
        shape = CAShapeLayer()
        shape.lineCap = kCALineCapRound
        shape.path = path.cgPath
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = 20.0
        shape.strokeEnd = 0
        shape.fillColor =  UIColor.clear.cgColor
        shape.position = view.center
        shape.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        view.layer.addSublayer(shape)
        
        // tap gesture recognizer
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
    }
    
    fileprivate func doAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        shape.add(animation, forKey: "someAnimation")
    }
    
    func doDownload() {
        percentageLabel.text = "0%"
        shape.strokeEnd = 0
        let queue = OperationQueue()
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: queue)
        
        guard let url = URL(string: urlString) else {return}
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("finished downloading")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage*100))%"
            self.shape.strokeEnd = percentage
        }
        
    }
    
    
    @objc func viewTapped() {
        doDownload()

//        doAnimation()
        
}
}

