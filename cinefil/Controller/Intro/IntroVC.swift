//
//  IntroVC.swift
//  cinefil
//
//  Created by zhou on 2/9/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

class IntroVC: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var pageContentView: UIView!

    var pageViewController: UIPageViewController!

    var steps = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        for storyboardId in ["IntroCinefilVC", "IntroUpcomingVC", "IntroDirectorVC"] {
            if let vc = storyboard?.instantiateViewControllerWithIdentifier(storyboardId) {
                steps.append(vc)
            }
        }
        setupPageViewController()
    }

    func setupPageViewController() {
        pageViewController = storyboard?.instantiateViewControllerWithIdentifier("IntroPageViewController") as! UIPageViewController
        pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60)
        pageViewController.dataSource = self
        pageViewController.setViewControllers([steps[0]], direction: .Forward, animated: true, completion: nil)


        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }

    @IBAction func didLoginButtonPressed(sender: AnyObject) {
        UserManager.isLogged = true
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.showCinefil()
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = steps.indexOf(viewController)
        if index <= 0 {
            return nil
        }
        return steps[index! - 1]
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = steps.indexOf(viewController)
        if index >= steps.count - 1 {
            return nil
        }
        return steps[index! + 1]
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return steps.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
