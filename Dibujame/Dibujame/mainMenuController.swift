//
//  ViewController.swift
//  Concienteme
//
//  Created by Rodolfo Castillo on 04/05/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class mainMenuController: UICollectionViewController {
    
    var imgData = [UIImage(named: "buli")!, UIImage(named: "chari")!, UIImage(named: "squi")!]
    var packChar = [UIImage(named: "char1")!, UIImage(named: "char2")!, UIImage(named: "char3")!, UIImage(named: "char4")!,UIImage(named: "char5")!,UIImage(named: "char6")!]
    var packBul = [UIImage(named: "bul1")!, UIImage(named: "bul2")!, UIImage(named: "bul3")!, UIImage(named: "bul4")!,UIImage(named: "bul5")!,UIImage(named: "bul6")!]
    var packSqui = [UIImage(named: "squ1")!, UIImage(named: "squ2")!, UIImage(named: "squ3")!, UIImage(named: "squ4")!,UIImage(named: "squ5")!,UIImage(named: "squ6")!]
    var nmData = ["Bulbasaur", "Charmander", "Squirtle"]
    var loveData: [Int] = [50, 32, 47, 31, 85, 45, 12, 96, 38, 17]
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.registerClass(SPAcell.self, forCellWithReuseIdentifier: "Cell")
        collectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension mainMenuController{
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgData.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SPAcell
        cell.photoLayer.image = imgData[indexPath.row]
        cell.titleLabel.text = nmData[indexPath.row]
//        cell.photoLayer.image = imageData[indexPath.row]
//        cell.titleLabel.text = self.spaData[indexPath.row]
//        cell.loveLabel.text = "\(loveData[indexPath.row])"
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.index = indexPath.row
//        print(spaData[index])
        performSegueWithIdentifier("next", sender: self)
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/3 - 20, height: self.view.frame.width/3 + 30)
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "next" {
            let nextScene =  segue.destinationViewController as! SftWrprView
            
            switch self.index {
            case 0:
                nextScene.pack = self.packBul
            case 1:
                nextScene.pack = self.packChar
            case 2:
                nextScene.pack = self.packSqui
            default:
                print("No valid Pack")
            }
            
            
        }
    }
}



