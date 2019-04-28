//
//  MovieSearchTableViewCell.swift
//  Movie Search
//
//  Created by Prajeesh Prabhakar on 4/27/19.
//  Copyright © 2019 Prajeesh Prabhakar. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSubtitle: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Seting Font
        movieTitle.font = UIFont.subheadlineFont()
        movieSubtitle.font = UIFont.captionFont()
        
        //Setting Image
        movieImageView.image = UIImage(named: Constants.placeholder)
        movieImageView.clipsToBounds = true
        
        //Activity Indicator View
        bringSubviewToFront(activityIndicator) 
        activityIndicator?.isHidden = true
        activityIndicator?.stopAnimating()
        
    }
    
    func set(title: String?, subtitle: String?, poster: UIImage?) {
        if let movieTitle = title {
            self.movieTitle.text = movieTitle
        }
        if let movieSubtitle = subtitle {
            self.movieSubtitle.text = movieSubtitle
        }
        if let moviePoster = poster {
            self.movieImageView.image = moviePoster
        }
    }
}
