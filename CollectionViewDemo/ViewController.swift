//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Minh.Thang on 6/12/19.
//  Copyright © 2019 Minh.Thang. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var list = [Int](0...100)
    var numberOfItemsInRow : CGFloat = 3
    let minimumInteritemSpacing : CGFloat = 1
    let minimumLineSpacing : CGFloat = 1
    
    var isPortrait = true 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberOfItemsInRow =  self.isPortrait ? 3 : 6
        let itemSize = ( self.view.frame.width - (( self.numberOfItemsInRow - 1) *  self.minimumInteritemSpacing)) /  self.numberOfItemsInRow
        self.collectionViewFlowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        self.collectionViewFlowLayout.minimumInteritemSpacing =  self.minimumInteritemSpacing
        self.collectionViewFlowLayout.minimumLineSpacing =  self.minimumLineSpacing
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidRotate), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func deviceDidRotate(notification: NSNotification) {
        let orientation = UIDevice.current.orientation
        if orientation == UIDeviceOrientation.portrait || orientation == UIDeviceOrientation.portraitUpsideDown {
            isPortrait = true
        } else {
           isPortrait =  false
        }
       
    }
    
    override func viewWillTransition( to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator ) {
        DispatchQueue.main.async() {
            self.collectionViewFlowLayout.invalidateLayout()
             self.numberOfItemsInRow =  self.isPortrait ? 3 : 6
            let itemSize = ( self.view.frame.width - (( self.numberOfItemsInRow - 1) *  self.minimumInteritemSpacing)) /  self.numberOfItemsInRow
             self.collectionViewFlowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
             self.collectionViewFlowLayout.minimumInteritemSpacing =  self.minimumInteritemSpacing
             self.collectionViewFlowLayout.minimumLineSpacing =  self.minimumLineSpacing
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.title.text = String(list[indexPath.row])
        return cell
    }

}

