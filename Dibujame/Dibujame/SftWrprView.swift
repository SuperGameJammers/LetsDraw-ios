//
//  SftWrprView.swift
//  Dibujame
//
//  Created by Rodolfo Castillo on 08/05/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class SftWrprView: UIViewController {
    
    var pack: [UIImage]!
    var drawboard: DrawView!
    var sendButton: UIButton!
    var cancelButton: UIButton!
    var uimage: UIImageView!
    var nImage: UIImageView!
    var currentImage: UIImageView!
    var notice: UILabel!
    
    var aux = 0
//    var parent: mainMenuController!
    
    
    override func viewDidLoad() {
        self.drawboard = DrawView(frame: self.view.frame)
        self.notice = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * (3/4), height: self.view.frame.width * (3/4)))
        self.notice.backgroundColor = UIColor.greenColor()
        self.notice.layer.cornerRadius = 10
        self.notice.center = self.view.center
        self.notice.clipsToBounds = true
        self.notice.textColor = UIColor.whiteColor()
        self.notice.text = "BIEN"
        self.notice.font = UIFont(name: "HelveticaNeue", size: 50)
        self.notice.textAlignment = .Center
        self.notice.alpha = 0
        self.view.addSubview(drawboard)
        self.setUpImages()
        self.setUpButtons()
        super.viewDidLoad()
    }
    
    
    func setUpBoard(){
        if drawboard != nil {
            self.drawboard.removeFromSuperview()
            drawboard = nil
            self.drawboard = DrawView(frame: self.view.frame)
            self.view.addSubview(drawboard)
        }
        self.setUpButtons()
    }
    
    func setUpImages(){
        self.currentImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        self.nImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        self.currentImage.image = pack[aux]
        self.nImage.image = pack[aux + 1]
        self.aux = 2
        self.currentImage.center = self.view.center
        self.nImage.center = self.view.center
        self.nImage.frame.origin.x = self.view.frame.width
        self.nImage.alpha = 0.2
        self.currentImage.alpha = 0.2
        self.view.addSubview(currentImage)
        self.view.addSubview(nImage)
        
    }
    
    func setUpButtons(){
        self.sendButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        self.cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        self.sendButton.addTarget(self, action: #selector(SftWrprView.addUserDraw(_:)), forControlEvents: .TouchUpInside)
        self.cancelButton.addTarget(self, action: #selector(SftWrprView.closeDown(_:)), forControlEvents: .TouchUpInside)
        self.sendButton.setTitle("✔︎", forState: .Normal)
        self.cancelButton.setTitle("✗", forState: .Normal)
        self.sendButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.sendButton.layer.cornerRadius = 40
        self.sendButton.backgroundColor = UIColor.greenColor()
        self.sendButton.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = 40
        self.cancelButton.backgroundColor = UIColor.redColor()
        self.cancelButton.clipsToBounds = true
        self.cancelButton.center = CGPoint(x: self.view.frame.width - 50, y: self.view.frame.height - 50)
        self.sendButton.center = CGPoint(x: self.cancelButton.center.x - 90, y: self.view.frame.height - 50)
        self.view.addSubview(sendButton)
        self.view.addSubview(cancelButton)
        self.view.bringSubviewToFront(currentImage)
        self.view.bringSubviewToFront(nImage)
    }
    
    func addUserDraw(sender: AnyObject){
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.uimage = UIImageView(frame: self.view.frame)
        self.uimage.alpha = 0.2
        self.uimage.image = drawboard.willContext.readPixelsAsUIImageFromCurrentTarget()
        var imgData = UIImagePNGRepresentation(uimage.image!)
        var data = imgData?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        self.setUpBoard()
        self.view.addSubview(uimage)
        UIGraphicsEndImageContext()
        let rocket = URLrequests()
        if currentImage.image == pack.last! {
            noticeAnimation()
            self.view.bringSubviewToFront(uimage)
        } else {
            swipeImage()
        }
        //RocketIT
    }
    
    func nextImage(){
        self.currentImage.image = self.nImage.image
        if self.aux < pack.count {
            self.nImage.image = pack[self.aux]
            self.aux += 1
        }
    }
    
    func closeDown(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func swipeImage(){
        UIView.animateWithDuration(0.4, delay: 0, options: [], animations: {
            self.currentImage.frame.origin.x = 0 - self.view.frame.width
            self.nImage.frame.origin.x = 0
        }) { (completion: Bool) in
            self.currentImage.frame.origin.x = 0
            self.nImage.frame.origin.x = self.view.frame.width
            self.nextImage()
        }
    }
    
    func noticeAnimation(){
        self.view.addSubview(notice)
        UIView.animateWithDuration(0.3, animations: {
            self.notice.alpha = 1
        })
        UIView.animateWithDuration(0.4, delay: 0.32, options: [], animations: {
            self.notice.alpha = 0
        }) { (completion: Bool) in
            self.closeDown(self)
        }
    }
    
    
    
}
