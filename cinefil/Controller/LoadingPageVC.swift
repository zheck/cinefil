//
//  LoadingPageVC.swift
//  cinefil
//
//  Created by Fong ZHOU on 29/02/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

class LoadingPageVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        MovieManager.instance.fetchGenres(
            {
                self.showCinefil()
            },
            failure: { (error) -> Void in
                self.spinner.stopAnimating()

                let alertView = UIAlertController(title: "Error", message: "Service Not Available", preferredStyle: .Alert)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        )
    }

    func showCinefil() {
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.showCinefil()
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
