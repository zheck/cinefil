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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        let hub = BXProgressHUD.showHUDAddedTo(self.view)
        MovieManager.getPopularMovies({ (movies) -> Void in
            hub.hide()
            self.movies = movies
            self.tableView.reloadData()
            }) { (error) -> Void in
                print(error.description)
                hub.hide()
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CinefilMovieCellID", forIndexPath: indexPath) as! CinefilMovieCell
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
            let cinefilCell = cell as! CinefilMovieCell
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
