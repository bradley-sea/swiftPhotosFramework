//
//  ViewController.swift
//  Week3App
//
//  Created by Bradley Johnson on 8/3/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, SelectedPhotoDelegate {
    
    var collectionsFetchResults = [PHFetchResult]()
    var collectionsLocalizedTitles = [String]()
                            

    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        var smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.AlbumRegular, options: nil)
//        var topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
//        self.collectionsFetchResults = [smartAlbums,topLevelUserCollections]
//        self.collectionsLocalizedTitles = ["Smart Albums", "Albums"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    
//    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
//        
//        return 1 + self.collectionsFetchResults.count
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        
//        if segue.identifier == "Photo" {
//            var gridVC = segue.destinationViewController as GridViewController
//            gridVC.assetsFetchResults = PHAsset.fetchAssetsWithOptions(nil)
//            
//        }
//    }
    
    //MARK: UICollectionViewDataSource
    
//    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
//        
//        if section == 0 {
//            return 1
//        }
//        else {
//            var fetchResult = self.collectionsFetchResults[section - 1] as PHFetchResult
//            var numberOfRows = fetchResult.count
//            return numberOfRows
//        }
//    }
//    
//    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumsCell", forIndexPath: indexPath) as UITableViewCell
//        if indexPath.section == 0 {
//            cell.textLabel.text = "All Photos"
//        }
//        else {
//            var fetchResult = self.collectionsFetchResults[indexPath.section - 1]
//            var collection = fetchResult[indexPath.row] as PHCollection
//            cell.textLabel.text = collection.localizedTitle
//        }
//        return cell
//    }
//    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ShowGrid" {
            let gridVC = segue.destinationViewController as GridViewController
            gridVC.assetsFetchResults = PHAsset.fetchAssetsWithOptions(nil)
            gridVC.delegate = self
        }
    }
    
    func photoSelected(asset : PHAsset) -> Void {
        
        var targetSize = CGSize(width: CGRectGetWidth(self.imageView.bounds), height: CGRectGetHeight(self.imageView.bounds))
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFit, options: nil, resultHandler: {(result : UIImage!, [NSObject : AnyObject]!) -> Void in
            
            if result {
                self.imageView.image = result
            }
            
            })

        
        
        
    }
}

