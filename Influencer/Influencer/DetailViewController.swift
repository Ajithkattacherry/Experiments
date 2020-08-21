//
//  DetailViewController.swift
//  Influencer
//
//  Created by Ajith Anthony on 7/5/20.
//  Copyright © 2020 Ajith Antony. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var customView: UIView!
    var panGesture = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        customView.isUserInteractionEnabled = true
        customView.addGestureRecognizer(panGesture)
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer) {
        let origin = customView.center
        if sender.state == .began {
            self.view.bringSubviewToFront(customView)
            let translation = sender.translation(in: self.view)
            customView.center = CGPoint(x: customView.center.x + translation.x, y: customView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        } else if sender.state == .ended {
            customView.center = origin
        }
    }
}
