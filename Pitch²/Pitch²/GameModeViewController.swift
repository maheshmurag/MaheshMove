//
//  GameModeViewController.swift
//  PitchSquared
//
//  Created by Cluster 5 on 7/16/14.
//  Copyright (c) 2014 Alex Yeh. All rights reserved.
//

import UIKit


class GameModeViewController: UIViewController {
    
    @IBOutlet var matching: UIButton
    @IBOutlet var freeplay: UIButton
    @IBOutlet var hero: UIButton
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.contentSizeForViewInPopover = CGSizeMake(320, 338);
    }

    override func viewDidAppear(animated: Bool)  {
        UIView.animateWithDuration(0.5, animations: {
            self.matching.frame = CGRect(x: 1024, y: self.matching.frame.origin.y , width: self.matching.frame.size.width, height: self.matching.frame.size.height)
            }, completion: {(value: Bool) in})
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.freeplay.frame = CGRect(x: 1024, y: self.freeplay.frame.origin.y , width: self.freeplay.frame.size.width, height: self.freeplay.frame.size.height)
            }, completion: {(value: Bool) in})
        UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.hero.frame = CGRect(x: 1024, y: self.hero.frame.origin.y , width: self.hero.frame.size.width, height: self.hero.frame.size.height)
            }, completion: {(value: Bool) in})

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
