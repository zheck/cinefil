//
//  AllocineVC.swift
//  cinefil
//
//  Created by Fong ZHOU on 07/03/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit
import BXProgressHUD

class AllocineVC: CinefilBaseVC {

    @IBOutlet weak var tableView: UITableView!

    let kCloseCellHeight: CGFloat = 140
    let kOpenCellHeight: CGFloat = 352

    var movies: [Movie] = []
    var appearedMovies: [Movie] = []
    var cellHeights = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: AllocineMovieCellNibName, bundle: nil), forCellReuseIdentifier: AllocineMovieCellID)
        let hub = BXProgressHUD.showHUDAddedTo(self.view)
        AllocineManager.instance.fetchMovies(
            { movies in
                hub.hide()
                self.movies = movies
                self.createCellHeightsArray()
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.reloadData()
            },
            failure: { error in
                hub.hide()
                print(error.description)
            }
        )
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

extension AllocineVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        let foldingCell = cell as! AllocineMovieCell
        foldingCell.backgroundColor = UIColor.clearColor()

        let isFolding = cellHeights[indexPath.row] == kCloseCellHeight
        foldingCell.selectedAnimation(!isFolding, animated: false, completion:nil)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AllocineMovieCellID, forIndexPath: indexPath) as! AllocineMovieCell
        let movie = movies[indexPath.row]
        cell.setupWithMovie(movie)

        if !appearedMovies.contains(movie) {
            appearedMovies.append(movie)
            cell.presentWithAnimation()
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AllocineMovieCell
        guard !cell.isAnimating() else { return }

        //        loadAdditionnalInfoForCell(cell)
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else { // close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut,
            animations: {
                tableView.beginUpdates()
                tableView.endUpdates()
            },
            completion: nil
        )
    }
//
//    func loadAdditionnalInfoForCell(cell: HomeMovieCell) {
//        let movie = cell.movie!
//        guard !movie.additionnalInfoLoaded else {
//            cell.loadAdditionnalInfo(movie)
//            return
//        }
//
//        MovieManager.instance.fetchAdditionnalInformation(movie,
//            success: {
//                cell.loadAdditionnalInfo(movie)
//            },
//            failure: { (error) -> Void in
//            }
//        )
//    }

    // Reset backdrop image position in cells
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            let cinefilCell = cell as! AllocineMovieCell
            cinefilCell.cellOnTableViewDidScroll(tableView, view: view)
        }
    }

}
