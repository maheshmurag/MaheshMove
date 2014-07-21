//
//  GameOverViewController.swift
//  PitchSquared
//
//  Created by Cluster 5 on 7/15/14.
//  Copyright (c) 2014 Alex Yeh. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet var highScoreLabel: UILabel
    @IBOutlet var scoreLabel: UILabel
    
    @IBOutlet var scores: UIButton
    @IBOutlet var help: UIButton
    @IBOutlet var start: UIButton
    
    @IBOutlet var startLabel: UILabel
    @IBOutlet var scoresLabel: UILabel
    @IBOutlet var helpLabel: UILabel
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var pitchData: PitchData = PitchData.sharedInstance;
        println(pitchData.score);
        self.scoreLabel.text =  NSString(format: "Score: %i", pitchData.score);
        if(pitchData.highscore == 0 || pitchData.highscore < pitchData.score) {
            println(pitchData.highscore);
            pitchData.highscore = pitchData.score;
        }
        self.highScoreLabel.text = NSString(format: "High Score: %i", pitchData.highscore);
        pitchData.scoreArray.append(Int(pitchData.score));
        pitchData.scoreArray.sort({ $0 > $1 });
        println(pitchData.scoreArray);
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        defaults.setObject(pitchData.scoreArray, forKey: "scoreArray");
        NSUserDefaults.standardUserDefaults().synchronize();
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.start.alpha = 1.0;
                    }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.scores.alpha = 1.0;
                    }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 0.6, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.help.alpha = 1.0;
                    }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.startLabel.alpha = 1.0;
                    }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.scoresLabel.alpha = 1.0;
                    }, completion: {(value: Bool) in})
                UIView.animateWithDuration(0.5, delay: 1.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.helpLabel.alpha = 1.0;
                    }, completion: {(value: Bool) in})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToHighScore(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("High Score") as UIViewController;
        self.presentViewController(vc, animated: true, completion: nil);
    }

    @IBAction func playAgain(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("Game1") as UIViewController;
        self.presentViewController(vc, animated: true, completion: nil);
    }
    
    @IBAction func goToMenu(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("Menu") as UIViewController;
        self.presentViewController(vc, animated: true, completion: nil);
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
