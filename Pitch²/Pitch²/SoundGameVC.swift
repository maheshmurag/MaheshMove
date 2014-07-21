//
//  ScoreTableViewController.swift
//  Pitch
//
//  Created by Cluster 5 on 7/9/14.
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
    
    @IBOutlet var glabelX : UILabel
    
    @IBOutlet var glabelY : UILabel
    
    @IBOutlet var glabelZ : UILabel
    
    
    @IBOutlet var debugL: UILabel
    
    var xVal : CDouble;
    var yVal : CDouble;
    var zVal : CDouble;
    @IBOutlet var calibrateButton: UIButton
    init(coder aDecoder: NSCoder!)
    {    xVal = 0;
        yVal = 0;
        zVal = 0;
        super.init(coder: aDecoder)
        startAccelerationCollection()
    
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        xVal = 0;
        yVal = 0;
        zVal = 0;
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
    }
    
    
    
    func startAccelerationCollection() -> Void{
        //        debugL.text = "startAccelerationCollection()"
        motionManager.accelerometerUpdateInterval = 0.2

        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(accelerometerData :     CMAccelerometerData!, error : NSError!) in
            
        self.alabelX.text = String("aX = \(accelerometerData.acceleration.x)");
        self.alabelY.text = String("aY = \(accelerometerData.acceleration.y)");
         self.alabelZ.text = String("aZ = \(accelerometerData.acceleration.z)");
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backButton.layer.cornerRadius = 5.0;
        backButton.layer.borderWidth = 2.0;
        backButton.layer.borderColor = UIColor(red: 79/255, green: 225/255, blue: 180/255, alpha: 1.0).CGColor;
        startAccelerationCollection()

        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
