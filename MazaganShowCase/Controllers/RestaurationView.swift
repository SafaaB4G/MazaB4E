//
//  ViewControllerSegmented.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 4/3/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import Foundation
import UIKit
import SJFluidSegmentedControl
import SKPhotoBrowser

class RestaurationView: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,SKPhotoBrowserDelegate{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
   
   
    
    
    var images = [SKPhotoProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("helloooo")

        SKPhotoBrowserOptions.displayToolbar = true                              // all tool bar will be hidden
        SKPhotoBrowserOptions.displayCounterLabel = true                         // counter label will be hidden
        SKPhotoBrowserOptions.displayBackAndForwardButton = false                 // back / forward button will be hidden
       SKPhotoBrowserOptions.displayAction = true                               // action button will be hidden
       SKPhotoBrowserOptions.displayDeleteButton = true                          // delete button will be shown
        SKPhotoBrowserOptions.displayHorizontalScrollIndicator = true            // horizontal scroll bar will be hidden
        SKPhotoBrowserOptions.displayVerticalScrollIndicator = true              // vertical scroll bar will be hidden
        SKPhotoBrowserOptions.displayStatusbar = false                             // status bar will be hidden
        SKPhotoBrowserOptions.disableVerticalSwipe = true


       let photo = SKPhoto.photoWithImageURL("http://beyond4edges.com/img/logo.png")
        let photos = SKPhoto.photoWithImageURL("https://vinci.ma/wp-content/uploads/photo-gallery/_DSC0319.JPG")
        photo.shouldCachePhotoURLImage = true // you can use image cache by true(NSCache)

        
       images.append(photo)
       images.append(photos)


        

        
        
        
        // 2. create PhotoBrowser Instance, and present.
        

        let browser = SKPhotoBrowser(photos: images)
        browser.delegate = self

        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})

        
        // Static setup
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayStatusbar = true
        
        setupTestData()
        setupCollectionView()
       self.view.backgroundColor = UIColor.gray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: - UICollectionViewDataSource

  extension RestaurationView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as? ExampleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.exampleImageView.image = UIImage(named: "casa\((indexPath as NSIndexPath).row % 10).jpg")
              cell.exampleImageView.contentMode = .scaleAspectFill
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RestaurationView {
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ExampleCollectionViewCell else {
            return

            
        }
        guard let originImage = cell.exampleImageView.image else {
            return




        }
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: images, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
        browser.delegate = self
                browser.updateCloseButton(UIImage(named: "casa.jpg")!)

        
        present(browser, animated: true, completion: {})
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 300)
            

        } else {
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 5, height: 200)
        }
    }
}


// MARK: - SKPhotoBrowserDelegate

extension RestaurationView {
    func didShowPhotoAtIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
        
        
        print("didShowPhotoAtIndex")

    }
    
    func willDismissAtPageIndex(_ index: Int) {
        collectionView.visibleCells.forEach({$0.isHidden = false})
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
        print("willDismissAtPageIndex")

        
    }
    
    func willShowActionSheet(_ photoIndex: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(_ index: Int) {
        collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
    }
    
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
        // handle dismissing custom actions
    }
    
    func removePhoto(index: Int, reload: (() -> Void)) {
        reload()
    }
    
    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
}

// MARK: - private

private extension RestaurationView {
    func setupTestData() {
        images = createLocalPhotos()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createLocalPhotos() -> [SKPhotoProtocol] {
        return (0..<10).map { (i: Int) -> SKPhotoProtocol in
            let photo = SKPhoto.photoWithImageURL("https://vinci.ma/wp-content/uploads/photo-gallery/_DSC0319.JPG")
            photo.caption = caption[i%10]
                      photo.contentMode = .scaleAspectFill
            return photo
            
            
            
                    }
    }
}

class ExampleCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var exampleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exampleImageView.image = nil
        layer.cornerRadius = 25.0
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        exampleImageView.image = nil
    }
}

var caption = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
               "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
               "It has survived not only five centuries, but also the leap into electronic typesetting",
               "remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
]
