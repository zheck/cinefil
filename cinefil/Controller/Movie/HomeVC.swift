//
//  CinefilVC.swift
//  cinefil
//
//  Created by zhou on 2/13/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit
import BXProgressHUD

class HomeVC: CinefilBaseVC {

    @IBOutlet weak var tableView: UITableView!

    var movies: [Movie] = []
    var appearedMovies: [Movie] = []

    let kCloseCellHeight: CGFloat = 140

    let kOpenCellHeight: CGFloat = 424

    var cellHeights = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: HomeMovieCellNibName, bundle: nil), forCellReuseIdentifier: HomeMovieCellID)
        let hub = BXProgressHUD.showHUDAddedTo(self.view)
        MovieManager.getPopularMovies({ (movies) -> Void in
            hub.hide()

            self.movies = movies
            self.createCellHeightsArray()
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
            }) { (error) -> Void in
                print(error.description)
                hub.hide()
        }
    }

    func createCellHeightsArray() {
        for _ in 0...movies.count {
            cellHeights.append(kCloseCellHeight)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        let foldingCell = cell as! HomeMovieCell
        foldingCell.backgroundColor = UIColor.clearColor()

        let isFolding = cellHeights[indexPath.row] == kCloseCellHeight
        foldingCell.selectedAnimation(!isFolding, animated: false, completion:nil)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cell = tableView.cellForRowAtIndexPath(indexPath) as! HomeMovieCell

        if cell.isAnimating() {
            return
        }

        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeMovieCellID, forIndexPath: indexPath) as! HomeMovieCell
        let movie = movies[indexPath.row]
        cell.setupWithMovie(movie)

        if !appearedMovies.contains(movie) {
            appearedMovies.append(movie)
            cell.presentWithAnimation()
        }

        return cell
    }

    // Reset backdrop image position in cells
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            let cinefilCell = cell as! HomeMovieCell
            let cellPositionInView = tableView.convertRect(cell.frame, toView: view)
            let distanceFromCenter = view.frame.size.height / 2 - cellPositionInView.origin.y
            let spacing = cinefilCell.backdropImageView.frame.size.height - cell.frame.size.height
            let movement = (distanceFromCenter / view.frame.size.height) * spacing
            var imageRect = cinefilCell.backdropImageView.frame
            imageRect.origin.y = movement - spacing / 2
            cinefilCell.backdropImageView.frame = imageRect
        }
    }

}
