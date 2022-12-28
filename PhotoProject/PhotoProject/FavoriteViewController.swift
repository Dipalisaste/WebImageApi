//
//  FavoriteViewController.swift
//  PhotoProject
//
//  Created by Felix-ITS015 on 26/07/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var favoriteList = [Int:Bool]()
    var tempList = [Int]()

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        for i in 0...favoriteList.count{
            if favoriteList[i] == true{
            tempList.append(i)
                
    }
}
    
    }
}
extension FavoriteViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! FavoriteCollectionViewCell
        let obj2 = photos[tempList[indexPath.row]]
        cell.favoriteImageView.sd_setImage(with: URL(string: obj2.url), completed: nil)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 108)
    }
    
}

