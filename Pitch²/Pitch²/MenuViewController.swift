//
//  MenuViewController.swift
//  Pitch
//
//  Created by Cluster 5 on 7/9/14.
//  Copyright (c) 2014 Alex Yeh. All rights reserved.
//

import UIKit
import Foundation

class MenuViewController: UIViewController, UIPopoverControllerDelegate {
    
    @IBOutlet var pitchTitle: UILabel
    @IBOutlet var squaredLabel: UILabel
    @IBOutlet var scores: UIButton
    @IBOutlet var help: UIButton
    @IBOutlet var start: UIButton
    
    @IBOutlet var startLabel: UILabel
    @IBOutlet var scoresLabel: UILabel
    @IBOutlet var helpLabel: UILabel
    
//    @IBOutlet var startCover: UIView
//    @IBOutlet var highScoreCover: UIView
//    @IBOutlet var helpCover: UIView 
    var popover: UIPopoverController;
    var popoverContent: UIViewController;
    
    init(coder aDecoder: NSCoder!)
    {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        self.popoverContent = storyboard.instantiateViewControllerWithIdentifier("GameMode") as UIViewController
        self.popover = UIPopoverController(contentViewController: popoverContent)
        super.init(coder: aDecoder)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        self.popoverContent = storyboard.instantiateViewControllerWithIdentifier("GameMode") as UIViewController
        self.popover = UIPopoverController(contentViewController: popoverContent)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.pitchTitle.frame = CGRect(x: 267, y: self.pitchTitle.frame.origin.y , width: self.pitchTitle.frame.size.width, height: self.pitchTitle.frame.size.height)
            }, completion: {
               (value: Bool) in
                UIView.animateWithDuration(0.5, animations: {
                    self.squaredLabel.alpha = 1.0;
                    self.start.alpha = 1.0;
                }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.scores.alpha = 1.0;
                }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.help.alpha = 1.0;
                }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 0.6, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.startLabel.alpha = 1.0;
                    }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.scoresLabel.alpha = 1.0;
                    }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.helpLabel.alpha = 1.0;
                    }, completion: {(value: Bool) in})
            });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pitchData: PitchData = PitchData.sharedInstance;
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        if let array = defaults.objectForKey("scoreArray") as? Int[]{
            pitchData.scoreArray = array;
            pitchData.highscore = array[0];
            println("WEFRWGRWQGQWREGQWREGQERGQERG");
            println(pitchData.scoreArray.count);
        }else{
            
            pitchData.scoreArray = [];
        }
    }
    
    @IBAction func showGameModes(sender: UIButton) {
        popoverContent.preferredContentSize = CGSizeMake(320 ,243);
        popover.delegate = self;
        popover.presentPopoverFromRect(sender.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true);
    }
    
    @IBAction func reset(sender: UIButton) {
//        self.pitchTitle.frame = CGRect(x: 278, y: self.pitchTitle.frame.origin.y , width: self.pitchTitle.frame.size.width, height: self.pitchTitle.frame.size.height)
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
