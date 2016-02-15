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

    override func viewDidLoad() {
        super.viewDidLoad()
        let hub = BXProgressHUD.showHUDAddedTo(self.view)
        tableView.dataSource = self
        tableView.delegate = self

        MovieManager.getPopularMovies({ (movies) -> Void in
            self.movies = movies
            hub.hide()
            self.tableView.reloadData()
            }) { (error) -> Void in
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
        cell.titleLabel.text = movie.title

        return cell
    }
}
