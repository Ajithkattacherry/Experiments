//
//  UpdateView.swift
//  Movie Search
//
//  Created by Prajeesh Prabhakar on 4/28/19.
//  Copyright © 2019 Prajeesh Prabhakar. All rights reserved.
//

import UIKit

class UpdateView: UIView {
    public var label:UILabel?
    
    public init(text: String) {
        super.init(frame: CGRect(x: 0.0,
                                 y: 0.0,
                                 width: 125.0,
                                 height: 50.0))
        
        // create the background image view
        guard var image = UIImage(named: Constants.bgImage) else { return }
        image = image.stretchableImage(withLeftCapWidth: 30,
                                       topCapHeight: 30)
        let imageView = UIImageView(frame:self.bounds)
        imageView.image = image
        self.addSubview(imageView)
        
        // create the activity label
        let activityIndicator  = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = self.newFrame(rect:activityIndicator.frame,
                                                origin:CGPoint(x: 13.0, y: 15.0))
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        
        // create the label
        label = UILabel()
        label?.text = text
        label?.font =  UIFont.boldSystemFont(ofSize: 12.0)
        label?.textColor = UIColor.white
        label?.backgroundColor = UIColor.clear
        label?.sizeToFit()
        label?.frame = self.newFrame(rect:(label?.frame)!,
                                     origin:CGPoint(x:activityIndicator.frame.maxX + 10.0, y:18.0))
        self.addSubview(label!)
        self.alpha = 0.0 // start out hidden
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addToView(aView:UIView ) {
        // position the view in the bottom left corner and add it to the given view
        self.autoresizingMask = [.flexibleRightMargin,.flexibleTopMargin ]
        
        self.frame = self.newFrame(rect:self.frame, origin:CGPoint(
            x:5.0,
            y:aView.frame.size.height - self.frame.size.height - 5.0
        ))
        
        aView.addSubview(self)
        self.superview?.bringSubviewToFront(aView)
    }
    
    
    public func show(show:Bool) {
        UIView.animate(withDuration: 0.3) {
            [weak self ] in
            self?.alpha = show ? 0.30 :0.0
        }
    }
    
    private func newFrame(rect:CGRect, origin:CGPoint) ->CGRect{
        var newFrame: CGRect = rect
        newFrame.origin = origin
        
        return newFrame
    }

    
}
