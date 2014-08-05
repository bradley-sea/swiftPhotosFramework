//
//  GridViewController.swift
//  Week3App
//
//  Created by Bradley Johnson on 8/3/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit
import Photos

class GridViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, SelectedPhotoDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var assetsFetchResults : PHFetchResult!
    var assetCollection : PHAssetCollection!
    var imageManager : PHCachingImageManager!
    
    var assetGridThumbnailSize : CGSize!
    
    var delegate : SelectedPhotoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.imageManager = PHCachingImageManager()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)    {
        var scale = UIScreen.mainScreen().scale
        var flowLayout = self.collectionView.collectionViewLayout as UICollectionViewFlowLayout
        var cellSize = flowLayout.itemSize
        self.assetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ShowPhoto" {
            var cell = sender as UICollectionViewCell
            var indexPath = self.collectionView.indexPathForCell(cell)
            let photoVC = segue.destinationViewController as SelectedPhotoViewController
            photoVC.asset = self.assetsFetchResults[indexPath.item] as PHAsset
            //photoVC.assetCollection = self.assetCollection
            photoVC.delegate = self
        }
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int  {
        return self.assetsFetchResults.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoCell
        
        var currentTag = cell.tag + 1
        cell.tag = currentTag
        
        var asset = self.assetsFetchResults[indexPath.item] as PHAsset
        
        self.imageManager.requestImageForAsset(asset, targetSize:self.assetGridThumbnailSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image : UIImage! ,info : [NSObject : AnyObject]!) -> Void in
            
            if cell.tag == currentTag {
                cell.imageView.image = image
            }
            
            })
        
        return cell
    }
    
    func photoSelected(asset : PHAsset) -> Void {
        //self.view.hidden = true
        self.delegate!.photoSelected(asset)        
    }

}
