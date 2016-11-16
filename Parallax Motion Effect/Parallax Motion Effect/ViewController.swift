//
//  ViewController.swift
//  Parallax Motion Effect
//
//  Created by Arjun Kodur on 11/16/16.
//  Copyright © 2016 Arjun Kodur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting min and max value for x and y axis
        let min = CGFloat(-85.0)
        let max = CGFloat(75.0)
        
        //Creating an instance of Motion effect and adding keypath,min and max values by which the view can tilted along the respective axis
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.maximumRelativeValue = max
        xMotion.minimumRelativeValue = min
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        //Adding motion effects to motionEffectsGroup array
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion, yMotion]
        
        //Adding the motion to the imageView
        imageView.addMotionEffect(motionEffectGroup)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

