//
//  FreeplayViewController.swift
//  PitchSquared
//
//  Created by Cluster 5 on 7/16/14.
//  Copyright (c) 2014 Alex Yeh. All rights reserved.
//

import UIKit
import CoreMotion

class FreeplayViewController: UIViewController {
    
    @IBOutlet var playButton: UIButton
    
    var xVal : CDouble = 0;
    var yVal : CDouble = 0;
    var zVal : CDouble = 0;
    @IBOutlet var backButton: UIButton
    @IBOutlet var calibrateButton: UIButton
    var xDiff : CDouble = 0;
    var yDiff : CDouble = 0;
    var zDiff : CDouble = 0;
    var freq : Int = 0
    var scale : Int = 0
    var hasRec : Bool = false;
    var freqList : Float[] = [110.0,116.54,123.47,130.81,138.59,146.83,155.56,164.81,174.61,185.00,196.00,207.65,220.0,233.08,246.94,261.63,277.18,293.66,311.13,329.63,349.23,369.99,392.63,415.30,440.00,466.16,493.88,523.25,554.37,587.33,622.25,659.25,698.46,739.99,783.99,830.61,880.0,932.33,987.77,1046.50,1108.73,1174.66,1244.51,1318.51,1396.91,1479.98,1567.98,1661.22,1760.00];
    
    
    var freqListNote : Dictionary<Float, String> = [110.0:"A2 ",116.54:"A2#",123.47:"B2 ",130.81:"C3 ",138.59:"C3#",146.83:"D3 ",155.56:"D3#",164.81:"E3 ",174.61:"F3 ",185.00:"F3#",196.00:"G3 ",207.65:"G3#",220.0:"A3 ",233.08:"A3#",246.94:"B3 ",261.63:"C4 ",277.18:"C4#",293.66:"D4 ",311.13:"D4#",329.63:"E4 ",349.23:"F4 ",369.99:"F4#",392.63:"G4 ",415.30:"G4#",440.00:"A4 ",466.16:"A4#",493.88:"B4 ",523.25:"C5 ",554.37:"C5#",587.33:"D5 ",622.25:"D5#",659.25:"E5 ",698.46:"F5 ",739.99:"F5#",783.99:"G5 ",830.61:"G5#",880.0:"A5 ",932.33:"A5#",987.77:"B5 ",1046.50:"C6 ",1108.73:"C6#",1174.66:"D6 ",1244.51:"D6#",1318.51:"E6 ",1396.91:"F6 ",1479.98:"F6#",1567.98:"G6 ",1661.22:"G6#",1760.00:"A6 "];
    // var timeMeasure : Dictionary<Double, CFloat>
    var dateStart : NSDate;
    var recordOn: Bool;
    var prevRec: Bool;
    @IBOutlet var recordOut: UIButton
    
    @IBAction func recordAction(sender: UIButton) {
        if(!recordOn){
            recordOut.setImage(UIImage(named: "recordOn.png"), forState: UIControlState.Normal)
            recordOn = !recordOn;
            dateStart=NSDate()
        } else {
                recordOut.setImage(UIImage(named: "recordOff.png"), forState: UIControlState.Normal)
            recordOn = !recordOn;
        }
        
        if(recordOn){
            dateStart = NSDate()
            PdBase.sendFloat(20000, toReceiver:"recLen" )
            PdBase.sendBangToReceiver("rec")
        }
        else if(recordOn != true && prevRec == true){
            PdBase.sendFloat(diffMill() * 44100.0, toReceiver: "resVal")
            println(diffMill() * 44100)
            PdBase.sendBangToReceiver("stop")
            hasRec = true;
           
        }
        prevRec = recordOn
    }
    @IBAction func playbackAction(sender: AnyObject) {
        if(hasRec){
            
        PdBase.sendBangToReceiver("replay")
        }
    }
  
    let motionManager = CMMotionManager()
    init(coder aDecoder: NSCoder!)
    {
        // freqToNote = [440.0: "A4", 466.16: "As4"]
        
        //timeMeasure = Dictionary<Double,CFloat>()
        recordOn = false;
        self.dateStart = NSDate();
        self.prevRec = false
        super.init(coder: aDecoder)
    }
    
    @IBAction func backAction(sender: UIButton) {
        stopUpdates()
    }
    
    func stopUpdates() -> Void{
        motionManager.stopAccelerometerUpdates();
        
    }
    func diffMill() -> Float{
        var dateCur: NSDate = NSDate()
       
        return  NSString(format: "%.2f", dateCur.timeIntervalSinceDate(dateStart)).floatValue;
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        dateStart = NSDate()
        //timeMeasure = Dictionary<Double,CFloat>()
        recordOn = false;
        self.prevRec = false
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Custom initialization
    }
    
    override func viewDidAppear(animated: Bool)  {
        //start
        
    }
    
    func calibrate() -> Void{
        
        xDiff = xVal;
        yDiff = yVal;
        zDiff = zVal;
        
        xVal -= xDiff
        yVal -= yDiff
        zVal -= zDiff
        
    }
    
    @IBAction func calibrateAction(sender: AnyObject) {
        calibrate()
    }
    
    
    func startAccelerationCollection() -> Void{
        motionManager.accelerometerUpdateInterval = 0.05
        
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(accelerometerData :     CMAccelerometerData!, error : NSError!) in
            
            self.xVal = accelerometerData.acceleration.x;
            self.yVal = accelerometerData.acceleration.y;
            self.zVal = accelerometerData.acceleration.z;
            
            var strX = NSString(format: "%.2f", self.xVal-self.xDiff);
            var strY = NSString(format: "%.2f", self.yVal-self.yDiff);
            var strZ = NSString(format: "%.2f", self.zVal-self.zDiff);
            
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
            self.playButton.setTitle(self.freqListNote[superfreq], forState: UIControlState.Normal);
            self.playButton.setTitle(self.freqListNote[superfreq], forState: UIControlState.Highlighted);
            UIView.animateWithDuration(0.1, animations:
                {self.playButton.setTitleColor(UIColor(red: strX.floatValue + 1, green: strY.floatValue + 1, blue: strZ.floatValue + 1, alpha: 1.0), forState: nil)
                    
                });
            if(self.playButton.touchInside)
            {//println("button pressed")
                PdBase.sendFloat(superfreq, toReceiver: "pitch")
                if(self.recordOn){
                    //self.timeMeasure.updateValue(NSString(format: "%.2f", superfreq).floatValue, forKey: self.diffMill());
                }
                    //self.playButton.titleLabel.text="";
                //self.playButton.titleLabel.text=self.freqListNote[superfreq];
                //self.playButton.titleLabel.sizeThatFits(CGSize(width: 300, height:150))
                //record sound to pd
            }
            else{
                //println("button let go")
                PdBase.sendFloat(0.0,toReceiver: "pitch")
            }
          //println(self.timeMeasure)
            })
       
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         recordOut.setImage(UIImage(named: "recordOff"), forState: UIControlState.Normal)
        
        startAccelerationCollection();
        
        backButton.layer.cornerRadius = 5.0;
        backButton.layer.borderWidth = 2.0;
        backButton.layer.borderColor = UIColor(red: 79/255, green: 225/255, blue: 180/255, alpha: 1.0).CGColor;
        
        calibrateButton.layer.cornerRadius = 5.0;
        calibrateButton.layer.borderWidth = 2.0;
        calibrateButton.layer.borderColor = UIColor(red: 79/255, green: 225/255, blue: 180/255, alpha: 1.0).CGColor;
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
