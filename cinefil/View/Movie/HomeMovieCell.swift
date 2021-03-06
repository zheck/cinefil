//
//  HomeMovieCell.swift
//  cinefil
//
//  Created by zhou on 2/19/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

let HomeMovieCellNibName = "HomeMovieCell"
let HomeMovieCellID = "HomeMovieCellID"

class HomeMovieCell: FoldingCell {

    @IBOutlet weak var backdropImageView: UIImageView!

    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var shadowMask: UIView!
    @IBOutlet weak var loaderImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!

    // Expanded view


    var movie: Movie?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        foregroundView.layer.masksToBounds = true

        posterImageView.layer.shadowOffset = CGSizeMake(2, 2)
        posterImageView.layer.shadowColor = UIColor.blackColor().CGColor
        posterImageView.layer.cornerRadius = 0.2
        posterImageView.layer.shadowRadius = 3.0
        posterImageView.layer.shadowOpacity = 0.80
        posterImageView.layer.shadowPath =  UIBezierPath(rect: posterImageView.layer.bounds).CGPath

        posterView.addBackgroundLayer(UIColor.colorFromHex("c8c8c8"), to:UIColor.colorFromHex("aaaaaa"))
        shadowMask.addBackgroundLayer(UIColor.clearColor(), to: UIColor.colorFromHex("000000", alpha: 0.9))
    }

    func setupWithMovie(movie: Movie) {
        self.movie = movie
        backdropImageView.image = nil
        backdropImageView.setMovieDbImage(movie.backDrop)
        posterImageView.image = nil
        posterImageView.setMovieDbImage(movie.poster)

        titleLabel.text = movie.title
        ratingLabel.text = String(movie.rating)
        genreLabel.text = MovieManager.instance.getGenresStringForMovie(movie)
        releaseDateLabel.text = movie.releaseDate
    }

    // Present with animation at first display
    func presentWithAnimation() {
        posterView.frame.origin.x = -90
        titleLabel.alpha = 0
        ratingLabel.alpha = 0
        starImageView.alpha = 0
        genreLabel.alpha = 0
        releaseDateLabel.alpha = 0

        animateLoader()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.posterView.frame.origin.x = 8
        }
        UIView.animateWithDuration(0.4, delay: 0.5, options: .CurveLinear, animations: { () -> Void in
            self.titleLabel.alpha = 1
            self.ratingLabel.alpha = 1
            self.starImageView.alpha = 1
            self.genreLabel.alpha = 1
            self.releaseDateLabel.alpha = 1
            }, completion: nil
        )
    }

    func animateLoader() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = CGFloat(2 * M_PI)
        rotation.speed = 5
        rotation.duration = 5.5
        rotation.repeatCount = .infinity
        loaderImageView.layer.addAnimation(rotation, forKey: "transform.rotation")
    }

    func loadAdditionnalInfo(movie: Movie) {

    }

    // MARK: - FoldingCell

    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
