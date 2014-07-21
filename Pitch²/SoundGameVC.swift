//
//  SoundGameVC.swift
//  Pitch
//
//  Created by Cluster 5 on 7/10/14.
//  Copyright (c) 2014 Alex Yeh. All rights reserved.
//

import UIKit

import CoreMotion
class SoundGameVC: UIViewController {
    
    let motionManager = CMMotionManager()
    var valuesXYZ : Array<Float> = [0.0,0.0,0.0]
    @IBOutlet var backButton: UIButton
    @IBOutlet var alabelX : UILabel
    @IBOutlet var alabelY : UILabel
    @IBOutlet var alabelZ : UILabel

    @IBOutlet var scoreLabel: UILabel
    @IBOutlet var calibrateButton: UIButton
    
    @IBOutlet var message: UILabel
    
    @IBOutlet var X3: UIImageView
    @IBOutlet var X2: UIImageView
    @IBOutlet var X1: UIImageView
    @IBOutlet var check: UIImageView
    @IBOutlet var countDown: UILabel
    
    @IBOutlet var sMode: UISwitch

    var xVal : CDouble;
    var yVal : CDouble;
    var zVal : CDouble;
    
    var initX: CDouble;
    var initY: CDouble;
    var initZ: CDouble;
    
    var xDiff : CDouble = 0;
    var yDiff : CDouble = 0;
    var zDiff : CDouble = 0;
    
    var scale : Int;
    var freq : Int;
    var initPitch: Float;

    var seconds: Int;
    var prevSecond: Int;
    var gameExit: Bool;
    var numWrong: Int;
    var score: Int;
    var timer5: NSTimer;
    var prevScale : Int;
    var round: Int;
    
    var freqList : Float[] = [110.0,116.54,123.47,130.81,138.59,146.83,155.56,164.81,174.61,185.00,196.00,207.65,220.0,233.08,246.94,261.63,277.18,293.66,311.13,329.63,349.23,369.99,392.63,415.30,440.00,466.16,493.88,523.25,554.37,587.33,622.25,659.25,698.46,739.99,783.99,830.61,880.0,932.33,987.77,1046.50,1108.73,1174.66,1244.51,1318.51,1396.91,1479.98,1661.22,1760.00];
    
    init(coder aDecoder: NSCoder!)
    {   xVal = 0;
        yVal = 0;
        zVal = 0;
        initX = 0;
        initY = 0;
        initZ = 0;
        initPitch = 0;
        seconds = 10;
        prevSecond = seconds;
        gameExit = false;
        numWrong = 0;
        score = 0;
        timer5 = NSTimer();
        freq = 1;
        scale = 2;
        prevScale = 0;
        round = 0;
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        xVal = 0;
        yVal = 0;
        zVal = 0;
        initX = 0;
        initY = 0;
        initZ = 0;
        initPitch = 0;
        seconds = 10;
        prevSecond = seconds;
        gameExit = false;
        numWrong = 0;
        score = 0;
        timer5 = NSTimer();
        freq = 1;
        scale = 2;
        prevScale = 0;
        round = 0;
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 5.0;
        backButton.layer.borderWidth = 2.0;
        backButton.layer.borderColor = UIColor(red: 79/255, green: 225/255, blue: 180/255, alpha: 1.0).CGColor;
        
        calibrateButton.layer.cornerRadius = 5.0;
        calibrateButton.layer.borderWidth = 2.0;
        calibrateButton.layer.borderColor = UIColor(red: 79/255, green: 225/255, blue: 180/255, alpha: 1.0).CGColor;
        
        startNewGame();
    }
    
    func startNewGame() -> Void {
        round++;
        if (!gameExit) {
            self.timer5.invalidate();
            
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("animateCountDown"), userInfo: nil, repeats: false);
        
            var timer1 = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: Selector("playRandomPitch"), userInfo: nil, repeats: false);
        }
    }
    
    func stopUpdates() -> Void{
        motionManager.stopAccelerometerUpdates();
        initPitch = 0
        timer5.invalidate()
        gameExit = true;
    }
    
    func calibrate() -> Void{
        
        xDiff = xVal;
        yDiff = yVal;
        zDiff = zVal;
        
        xVal -= xDiff
        yVal -= yDiff
        zVal -= zDiff
        
    }
    
    func playRandomPitch() -> Void {
        if (!gameExit) {
            UIView.animateWithDuration(0.5, animations: {
                self.message.font = UIFont(name: self.message.font.fontName, size: 40);
                self.message.text = String("Pitch Playing!");
                self.message.alpha = 1.0;
                });
        
            var index: Int = Int(arc4random() % 48);
            initPitch = self.freqList[index];
            //println(initPitch);
            PdBase.sendFloat(initPitch, toReceiver: "pitch");
        
            var timer1 = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector:    Selector("startAccelerationCollection"), userInfo: nil, repeats: false)
        
            var timer3 = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("startGameMessage"), userInfo: nil, repeats: false)
        }
    }
    
    func startGameMessage() -> Void{
        UIView.animateWithDuration(0.5, animations: {
            self.message.alpha = 0.0;
        }, completion: {
            (value: Bool)in
            UIView.animateWithDuration(0.5, animations: {
                self.message.text = String("Rotate the device to match the pitch!");
                self.message.alpha = 1.0;
                self.countDown.alpha = 1.0
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.message.alpha = 0.0;
                }, completion: {
                    (value: Bool) in
                });
            });
        });
        
        timer5 = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countDownTimer"), userInfo: nil, repeats: true);
        println("TIMER5: \(timer5)");
    }
    
    func countDownTimer() -> Void {
        if(seconds <= 0){
            numWrong++;
            if (numWrong == 1){
                UIView.animateWithDuration(0.5, animations: {
                    self.X1.alpha = 1.0;
                });
                timer5.invalidate();
                if(prevSecond > 6) {
                    prevSecond -= 2;
                }
                seconds = prevSecond;
                motionManager.stopAccelerometerUpdates();
                startNewGame();
            } else if (numWrong == 2) {
                UIView.animateWithDuration(0.5, animations: {
                    self.X2.alpha = 1.0;
                });
                timer5.invalidate();
                if(prevSecond > 6) {
                    prevSecond -= 2;
                }
                seconds = prevSecond;
                motionManager.stopAccelerometerUpdates();
                startNewGame();
            } else if (numWrong == 3) {
                UIView.animateWithDuration(0.5, animations: {
                    self.X3.alpha = 1.0;
                    var pitchData: PitchData = PitchData.sharedInstance;
                    pitchData.score = self.score;
                }, completion: { (value: Bool)in} );
                timer5.invalidate();
                self.stopUpdates();
                self.stopUpdates();
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
                let vc : GameOverViewController = storyboard.instantiateViewControllerWithIdentifier("GameOver") as GameOverViewController;
                self.presentViewController(vc, animated: true, completion: nil)
            }
        } else {
            seconds--;
            countDown.text = String(seconds);
        }
        
    }
    
    @IBAction func calibrateAction(sender: UIButton) {
        calibrate()
    }
    
    func animateCountDown() -> Void {
        UIView.animateWithDuration(0.5, animations: {
            self.message.font = UIFont(name: self.message.font.fontName, size: 152);
            self.message.text = String(3);
            self.message.alpha = 1.0;
        }, completion: {
            (value: Bool) in
            UIView.animateWithDuration(0.5, animations: {
                self.message.alpha = 0.0;
                }, completion: {
                    (value: Bool)in
                    UIView.animateWithDuration(0.5, animations: {
                        self.message.text = String(2);
                        self.message.alpha = 1.0;
                        }, completion: {
                            (value: Bool)in
                            UIView.animateWithDuration(0.5, animations: {
                                self.message.alpha = 0.0;
                                }, completion: {
                                    (value: Bool)in
                                    UIView.animateWithDuration(0.5, animations: {
                                        self.message.text = String(1);
                                        self.message.alpha = 1.0;
                                        }, completion: {
                                            (value: Bool)in
                                            UIView.animateWithDuration(0.5, animations: {
                                                self.message.alpha = 0.0;
                                            });
                                        });
                                 });
                        });
                });

        });
    }
    
    
    func startAccelerationCollection() -> Void{
        if (!gameExit) {
            motionManager.accelerometerUpdateInterval = 0.05
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(accelerometerData :     CMAccelerometerData!, error : NSError!) in
            
            self.xVal = accelerometerData.acceleration.x;
            self.yVal = accelerometerData.acceleration.y;
            self.zVal = accelerometerData.acceleration.z;
            
            var strX = NSString(format: "%.1f", self.xVal-self.xDiff);
            var strY = NSString(format: "%.1f", self.yVal-self.yDiff);
            var strZ = NSString(format: "%.2f", self.zVal-self.zDiff);
            
            self.alabelX.text =  strX
            self.alabelY.text =  strY
            self.alabelZ.text =  strZ
            
            var pitch = (strX).floatValue * 100 + 100;
            pitch *= (strY.floatValue * 10);
            
            self.freq = Int(floor(1.0+strX.doubleValue * 6.0))+6
            //println(strX.doubleValue)
            self.scale = Int(floor((strY.doubleValue + 1.0)*2))
            // println("freqB: \(self.freq)");
            if (self.scale) >= 3
            {  //println("octave: \(self.freqList[self.freq])")
                self.freq += 36;
                if(self.freq>=48){
                    self.freq = 47
                }
            }
            else if (self.scale) >= 2 {
                self.freq += 24
                
            }
            else if (self.scale) >= 1 {
                self.freq += 12
            }
            else{
                if(self.freq<=0)
                {
                    self.freq=0;
                }
            }
            
            var superfreq : CFloat =  self.freqList[self.freq]
            PdBase.sendFloat(superfreq, toReceiver: "pitch")
            
            if (fabsf(superfreq) == self.initPitch) {
                UIView.animateWithDuration(0.5, animations: {
                    self.check.alpha = 1.0
                }, completion: {
                    (value: Bool) in
                    UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                        self.check.alpha = 0.0
                    }, completion: {
                        (value: Bool) in
                        //
                    });
                });
                
                self.timer5.invalidate();
                self.score += 100;
                self.scoreLabel.text = String(self.score);
                if(self.prevSecond > 6){
                    self.prevSecond -= 2;
                }
                self.seconds = self.prevSecond;
                self.motionManager.stopAccelerometerUpdates();
                self.startNewGame();
            } else {
                if (self.sMode.on) {
                    UIView.animateWithDuration(0.1, animations: {
                        self.view.backgroundColor = UIColor(red: strX.floatValue + 1, green: strY.floatValue + 1, blue: strZ.floatValue + 1, alpha: 1.0);
                    });
                    
                } else {
                    UIView.animateWithDuration(0.1, animations: {
                        self.view.backgroundColor = UIColor.whiteColor()
                    });
                    
                }

            }
           
            })
        
        /*
        self.motionManager.gyroUpdateInterval = 0.2
        
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(gyroscopeData :     CMGyroData!, error : NSError!) in
        
        
        self.glabelX.text = String("gX = \(gyroscopeData.rotationRate.x)");
        self.glabelY.text = String("gY = \(gyroscopeData.rotationRate.y)");
        self.glabelZ.text = String("gZ = \(gyroscopeData.rotationRate.z)");
        
        //PdBase.sendList(data, toReceiver:"gyroscope")
        })
        */
        }
    }
    
    @IBAction func backAction(sender: UIButton) {
        self.stopUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
