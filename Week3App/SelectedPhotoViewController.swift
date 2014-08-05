//
//  SelectedPhotoViewController.swift
//  Week3App
//
//  Created by Bradley Johnson on 8/4/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit
import Photos

protocol SelectedPhotoDelegate {
    
    func photoSelected(asset : PHAsset) -> Void
}

class SelectedPhotoViewController: UIViewController {
    
    var asset : PHAsset!
    //var assetCollection : PHAssetCollection!
    var delegate : SelectedPhotoDelegate?

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var targetSize = CGSize(width: CGRectGetWidth(self.imageView.bounds), height: CGRectGetHeight(self.imageView.bounds))
        
        PHImageManager.defaultManager().requestImageForAsset(self.asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFit, options: nil, resultHandler: {(result : UIImage!, [NSObject : AnyObject]!) -> Void in
            
            if result {
                self.imageView.image = result
            }
            
            })
        
    }

    @IBAction func handleSelectPhotoButtonPressed(sender: AnyObject) {
        
        if self.delegate != nil {
            self.delegate!.photoSelected(self.asset)
        }
        
        self.navigationController.popToRootViewControllerAnimated(true)
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
