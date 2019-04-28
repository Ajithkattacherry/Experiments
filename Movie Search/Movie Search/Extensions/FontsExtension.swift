//
//  FontsExtension.swift
//  Movie Search
//
//  Created by Prajeesh Prabhakar on 4/27/19.
//  Copyright © 2019 Prajeesh Prabhakar. All rights reserved.
//

import UIKit

extension UIFont {
    // Apple Dynamic Fonts
    
    //20pt
    class func titleFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
    }
    
    //17pt- Bold
    class func headlineFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    }
    
    //17pt
    class func bodyFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    }
    
    //16pt
    class func calloutFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout)
    }
    
    //15pt
    class func subheadlineFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
    }
    
    //12pt
    class func captionFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
    }
    
    //Bold
    class func boldFont(of font: UIFont) -> UIFont {
        guard let boldDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold) else { return font }
        return UIFont(descriptor: boldDescriptor, size: 0)
    }
    
    class func lightFont(of font: UIFont) -> UIFont {
        return UIFont.systemFont(ofSize: font.pointSize, weight: .light)
    }
}
