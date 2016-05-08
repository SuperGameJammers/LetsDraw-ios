//
//  SPAcell.swift
//  Concienteme
//
//  Created by Rodolfo Castillo on 04/05/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class SPAcell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var difIcon: UIImageView!
    var frameLayer: UIImageView!
    var photoLayer: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.125
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.photoLayer = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width))
        self.photoLayer.backgroundColor = UIColor.whiteColor()
        self.addSubview(photoLayer)
        self.frameLayer = UIImageView(frame: CGRect(x: 10, y: 20, width: self.frame.width - 20, height: self.frame.width - 20))
        self.frameLayer.backgroundColor = UIColor.whiteColor()
        self.addSubview(frameLayer)
        self.frameLayer.layer.shadowOpacity = 0.125
        self.frameLayer.layer.shadowColor = UIColor.blackColor().CGColor
        self.frameLayer.layer.shadowRadius = 5
        self.frameLayer.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.bringSubviewToFront(photoLayer)
        self.titleLabel = UILabel(frame: CGRect(x: 3, y: self.photoLayer.frame.height + 5, width: self.frame.width - 3 - 13 - 5, height: 20))
        self.titleLabel.text = "Charmander"
        self.titleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 19)
        self.addSubview(titleLabel)
        self.difIcon = UIImageView(frame: CGRect(x: self.frame.width - 18, y: 0, width: 13, height: 13))
        self.difIcon.center.y = self.titleLabel.center.y
        self.difIcon.backgroundColor = UIColor.greenColor()
        self.difIcon.layer.cornerRadius = 13/2
        self.difIcon.clipsToBounds = true
        self.addSubview(difIcon)
//        requestImage("http://cdn.bulbagarden.net/upload/thumb/7/73/004Charmander.png/250px-004Charmander.png") { (image) -> Void in
//            self.photoLayer.image = image
//        }
//        self.downloadImage(NSURL(string: "http://static1.comicvine.com/uploads/scale_super/8/84251/1590245-charmander2.png")!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func requestImage(url: String, success: (UIImage?) -> Void) {
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }
    
    func requestURL(url: String, success: (NSData?) -> Void, error: ((NSError) -> Void)? = nil) {
        NSURLConnection.sendAsynchronousRequest(
            NSURLRequest(URL: NSURL (string: url)!),
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { response, data, err in
                if let e = err {
                    error?(e)
                } else {
                    success(data)
                }
        })
    }
    
}
