//
//  InfoPageViewController.swift
//  BeaconsTest
//
//  Created by Michael on 19/01/16.
//  Copyright © 2016 Smets Michael. All rights reserved.
//
//  Used Swift ios9 Book p.382

import Foundation
import UIKit


class InfoPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    
    
    var pageHeadings = ["Create Account", "Login", "Keep app running"]
    var pageImages = ["register_full", "login_pw", "Student"]
    var pageContent = ["Create an account with youre student mail adress", "Login with youre account", "Keep the app running in the background so that teachers can check youre attendance"]
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) ->
        UIViewController? {
        var index = (viewController as! InfoContentViewController).index
        index += 1
        return viewControllerAtIndex(index)
    }
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) ->
        UIViewController? {
        var index = (viewController as! InfoContentViewController).index
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> InfoContentViewController? {
            if index == NSNotFound || index < 0 || index >= pageHeadings.count {
            return nil
            }
            if let pageContentViewController =
            storyboard?.instantiateViewControllerWithIdentifier("InfoContentViewController")
            as? InfoContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            return pageContentViewController
            }
            return nil }
    
    func forward(index:Int) {
        if let nextViewController = viewControllerAtIndex(index + 1) {
            setViewControllers([nextViewController], direction: .Forward , animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            dataSource = self
            if let startingViewController = viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward,
             animated: true, completion: nil)
            }
    }
}