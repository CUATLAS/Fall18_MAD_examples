//
//  ViewController.swift
//  animation
//
//  Created by Aileen Pierce on 10/6/18.
//  Copyright © 2018 Aileen Pierce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var delta = CGPoint(x: 12, y: 4) //initialize the delta to move 12 pixels horizontally, 4 pixels vertically
    var ballRadius = CGFloat() //radius of the ball image
    var ballTimer = Timer() //animation timer
    var translation = CGPoint(x: 0.0, y: 0.0) //specifies how many pixels the image will move
    var angle: CGFloat=0.0 //angle for rotation
    
    //changes the position of the image view
    @objc func moveImage(){
        let newCenter = CGPoint(x: imageView.center.x + delta.x, y: imageView.center.y + delta.y)
//         imageView.center = newCenter
        let duration = Double(slider.value)
        
        //Animation
        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {self.imageView.center=newCenter})
        animator.startAnimation()
        
        if imageView.center.x  > view.bounds.size.width-ballRadius || imageView.center.x < ballRadius {
            delta.x = -delta.x
        }
        if imageView.center.y > view.bounds.size.height-ballRadius || imageView.center.y < ballRadius {
            delta.y = -delta.y
        }
        //Translation
        //        {self.imageView.transform=CGAffineTransform(translationX: self.translation.x, y: self.translation.y)
        //            self.translation.x += self.delta.x
        //            self.translation.y += self.delta.y
        //        }
        
//        if imageView.center.x + translation.x > view.bounds.size.width-ballRadius || imageView.center.x + translation.x < ballRadius {
//            delta.x = -delta.x
//        }
//        if imageView.center.y + translation.y > view.bounds.size.height-ballRadius || imageView.center.y + translation.y < ballRadius {
//            delta.y = -delta.y
//        }
        
        //Scaling
        //        UIView.animate(withDuration: duration, animations: {self.imageView.transform=CGAffineTransform(scaleX: self.angle, y: self.angle)
        //            self.imageView.center=CGPoint(x: self.imageView.center.x + self.delta.x, y: self.imageView.center.y + self.delta.y)
        //        })
        
        //Rotation
//        UIView.animate(withDuration: duration, animations: {self.imageView.transform=CGAffineTransform(rotationAngle: self.angle)
//            self.imageView.center=CGPoint(x: self.imageView.center.x + self.delta.x, y: self.imageView.center.y + self.delta.y)
//        })
        
        //Rotation
//        angle += 0.02 //amount by which you increment the angle
//        //if it's a full rotation reset the angle
//        if angle > .pi {
//            angle=0
//        }
        
        //Rotation
//        UIView.commitAnimations()
//        if imageView.center.x > view.bounds.size.width-ballRadius || imageView.center.x < ballRadius {
//            delta.x = -delta.x
//        }
//        if imageView.center.y > view.bounds.size.height-ballRadius || imageView.center.y < ballRadius {
//            delta.y = -delta.y
//        }
    }
    
    //updates the timer and label with the current slider value
    func changeSliderValue() {
        sliderLabel.text = String(format: "%.2f", slider.value)
        ballTimer = Timer.scheduledTimer(timeInterval: Double(slider.value), target: self, selector: #selector(self.moveImage), userInfo: nil, repeats: true)
    }

    @IBAction func sliderMoved(_ sender: UISlider) {
        ballTimer.invalidate()
        changeSliderValue()
    }
    
    override func viewDidLoad() {
        //ball radius is half the width of the image
        ballRadius=imageView.frame.size.width/2
        //set the starting position for the image view
        imageView.center.x = view.bounds.size.width/2
        imageView.center.y = view.bounds.size.height/2
        changeSliderValue()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

