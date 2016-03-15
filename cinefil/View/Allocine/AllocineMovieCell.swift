//
//  AllocineMovieCell.swift
//  cinefil
//
//  Created by Fong ZHOU on 07/03/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

let AllocineMovieCellNibName = "AllocineMovieCell"
let AllocineMovieCellID = "AllocineMovieCellID"

class AllocineMovieCell: FoldingCell {

    // Shadow
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var shadowMask: UIView!

    // Poster
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var loaderImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!

    // Expanded View

    @IBOutlet weak var expandedBackgroundImage: UIImageView!
    @IBOutlet var containerViews: [UIView]!

    var movie: Movie?
    var showTimes: [ShowTime]?

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
        for view in containerViews {
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.grayColor().CGColor
        }
    }

    func setupWithMovie(movie: Movie) {
        self.movie = movie
        backdropImageView.image = nil
        backdropImageView.setImageWithUrlString(movie.backDrop)
        posterImageView.image = nil
        posterImageView.setImageWithUrlString(movie.poster)

        titleLabel.text = movie.title
        ratingLabel.text = String(movie.rating)
        genreLabel.text = movie.getGenreString()
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

    // MARK: - FoldingCell

    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }

    func loadDetails(showTimes: [ShowTime]) {
        self.showTimes = showTimes
        expandedBackgroundImage.image = posterImageView.image

        for i in 0..<showTimes.count {
            let view = containerViews[i]
            if view.subviews.count > 0 {
                for subview in view.subviews {
                    subview.removeFromSuperview()
                }
            }
            let showTime = showTimes[i]
            loadShowTimes(view, showTime: showTime)
        }
    }

    func loadShowTimes(view: UIView, showTime: ShowTime) {
        let label = UILabel(frame: CGRect(x: 20, y: 8, width: frame.size.width - 40, height: 24))
        var posy = CGFloat(28.0)
        label.textColor = UIColor.whiteColor()
        label.text = showTime.theater.name
        view.addSubview(label)

        for showTimeSessions in showTime.sessions {
            let text = showTimeSessions.version + ":\n\t" + showTimeSessions.scr.joinWithSeparator(" ")
            let label = UILabel(frame: CGRect(x: CGFloat(20), y: posy, width: CGFloat(frame.size.width - 40), height: CGFloat(40)))
            posy += 40
            label.numberOfLines = 0
            label.lineBreakMode = .ByWordWrapping
            label.font = UIFont.systemFontOfSize(14)
            label.textColor = UIColor.whiteColor()
            label.text = text
            view.addSubview(label)
        }

    }

    // https://github.com/jberlana/JBParallaxCell
    func cellOnTableViewDidScroll(tableView: UITableView, view: UIView) {
        let rectInSuperview = tableView.convertRect(frame, toView: view)

        let distanceFromCenter = view.frame.size.height / 2 - rectInSuperview.origin.y
        let difference = backdropImageView.frame.size.height - frame.size.height
        let move = (distanceFromCenter / view.frame.size.height) * difference

        var imageRect = backdropImageView.frame
        imageRect.origin.y = move - difference / 2
        backdropImageView.frame = imageRect
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
