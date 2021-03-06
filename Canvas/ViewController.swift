//
//  ViewController.swift
//  Canvas
//
//  Created by Elijah Kumi on 3/12/18.
//  Copyright © 2018 Elijah Kumi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 215
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        var velocity = sender.velocity(in: view)
        
        let translation = sender.translation(in: view)
        print("translation \(translation)")
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)

        } else if sender.state == .ended {
            if velocity.y > 0.0 {
                self.trayView.center = self.trayDown
            } else {
                self.trayView.center = self.trayUp
            }
        }
        
        
    }
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        var velocity = sender.velocity(in: view)
        
        let translation = sender.translation(in: view)
        print("translation \(translation)")
        
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.isUserInteractionEnabled = true
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
    
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
       
        
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        print("translation \(translation)")
        
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
        }
    }
    
}
    
    




