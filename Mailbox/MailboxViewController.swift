//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Kunal Kshirsagar on 9/16/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var smallListIcon: UIImageView!
    @IBOutlet weak var smallBackImage: UIImageView!
    @IBOutlet weak var messageBackView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    var originalImageCenter: CGPoint!
    var originalSmallBackImageCenter: CGPoint!
    var originalSmallListImageCenter: CGPoint!
    var originalArchiveImageCenter: CGPoint!
    var originalDeleteImageCenter: CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        smallBackImage.alpha = 0 //hide the image
        smallListIcon.alpha = 0 //hide the list icon
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        // Do any additional setup after loading the view.
    }

    @IBAction func onTapReschedule(sender: AnyObject) {
        println("tap gesture recognized")
        rescheduleImage.alpha = 0
        listImageView.alpha = 0
        if(messageView.alpha != 1){
            messageView.alpha = 1
            messageView.center = originalImageCenter
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.feedImageView.center = CGPoint(x: self.feedImageView.center.x, y: self.feedImageView.center.y + self.messageView.frame.height)
            })
        }
    }
    @IBAction func onPan(gestureRecognizer: UIPanGestureRecognizer) {
        println("Successful pan")
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        println("location: \(location.x)")
        println("translation: \(translation.x)")
       // messageView.frame.x = CGRect(320 - location.x
            
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
        println("Pan began")
            originalImageCenter = messageView.center
            originalSmallBackImageCenter = smallBackImage.center
            originalSmallListImageCenter = smallListIcon.center
            originalArchiveImageCenter = archiveIcon.center
            originalDeleteImageCenter = deleteIcon.center
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Changed) {
            println("Pan changed")
            println("original: \(originalArchiveImageCenter)")
            messageView.center = CGPoint(x: originalImageCenter.x + translation.x, y: originalImageCenter.y)
            
            //start with light gray background color
            messageBackView.backgroundColor = UIColor.lightGrayColor()
            smallBackImage.center = CGPoint(x: originalSmallBackImageCenter.x + translation.x , y: originalSmallBackImageCenter.y)
            smallListIcon.center = CGPoint(x: originalSmallListImageCenter.x + translation.x, y: originalSmallListImageCenter.y)
            archiveIcon.center = CGPoint(x: originalArchiveImageCenter.x + translation.x, y: originalArchiveImageCenter.y)
            deleteIcon.center = CGPoint(x: originalDeleteImageCenter.x + translation.x, y: originalDeleteImageCenter.y)
            println("new: \(archiveIcon.center)")
            //show yellow color for reschedule options
            if(translation.x < -60) {
                //messageView.center = originalImageCenter
                messageBackView.backgroundColor = UIColor.yellowColor()
                smallBackImage.alpha = ((200 + translation.x)%200)
                println("alpha: \(smallBackImage.alpha)")
                smallListIcon.alpha = 0
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0
            }
            //show brown color for list options
            if(translation.x < -260) {
                //messageView.center = originalImageCenter
                messageBackView.backgroundColor = UIColor.brownColor()
                smallBackImage.alpha = 0
                smallListIcon.alpha = 1
                archiveIcon.alpha = 0
                 deleteIcon.alpha = 0
            }
            
            if(translation.x > 60){
                messageBackView.backgroundColor = UIColor.greenColor()
                smallBackImage.alpha = 0
                smallListIcon.alpha = 0
                archiveIcon.alpha = 1
                 deleteIcon.alpha = 0
            }
            if(translation.x > 260){
                messageBackView.backgroundColor = UIColor.redColor()
                smallBackImage.alpha = 0
                smallListIcon.alpha = 0
                archiveIcon.alpha = 0
                 deleteIcon.alpha = 1
            }
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            println("Pan ended")
            //show reschedule options
            if(translation.x < -60) {
                messageBackView.backgroundColor = UIColor.yellowColor()
                rescheduleImage.alpha = 1
                listImageView.alpha = 0
            }
            //show list options
            if(translation.x < -260) {
                listImageView.alpha = 1
                rescheduleImage.alpha = 0
            }
            if(translation.x > 60) {
                //
                messageBackView.backgroundColor = UIColor.greenColor()
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.messageView.alpha = 0
                    self.feedImageView.center = CGPoint(x: self.feedImageView.center.x, y: self.feedImageView.center.y - self.messageView.frame.height)
                })
            }
            if(translation.x > 260) {
                //
                messageBackView.backgroundColor = UIColor.redColor()
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.messageView.alpha = 0
                    self.feedImageView.center = CGPoint(x: self.feedImageView.center.x, y: self.feedImageView.center.y - self.messageView.frame.height)
                })
            }
            messageView.center = originalImageCenter
            smallBackImage.center = originalSmallBackImageCenter
            smallListIcon.center = originalSmallListImageCenter
            archiveIcon.center = originalArchiveImageCenter
            deleteIcon.center = originalDeleteImageCenter
    }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
