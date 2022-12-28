//
//  ViewController.swift
//  PhotoProject
//
//  Created by Felix-ITS015 on 20/07/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit
import SDWebImage

struct Photo:Decodable{
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
}
 var photos:[Photo]=[]
class ViewController: UIViewController {
    
   
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var favoriteImage = [Int:Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = true
        fetchAPI()
        photoCollectionView.allowsMultipleSelection = true
       // photoCollectionView.allowsSelection = true
    }

    
    @IBAction func favbttn(_ sender: Any) {
        let detailVc = storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        detailVc.favoriteList = favoriteImage
        navigationController?.pushViewController(detailVc, animated: true)
    }
    /* @IBAction func favbttn(_ sender: UIBarButtonItem) {
    
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        detailVC.favoriteList = favoriteImage
       // detailVC.favimg = obj1.url
        navigationController?.pushViewController(detailVC, animated: true)
    }*/
    
    private func blankfavoriteImage(){
        for i in 0...photos.count{
            favoriteImage[i] = false
        }
    }
    
    @objc func connected(_ sender:AnyObject){
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let obj1 = photos[sender.view.tag]
        detailVC.str = obj1.title
        detailVC.img = obj1.thumbnailUrl
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func fetchAPI(){
        let str = "https://jsonplaceholder.typicode.com/photos"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) {[unowned self] (data, response, error) in
            do{
                if error == nil{
            photos =  try JSONDecoder().decode([Photo].self, from: data!)
                
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }
        }
    }catch let error{
                print(error.localizedDescription)
            }
        }.resume()
}
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
         let obj = photos[indexPath.row]
        cell.photoImageView.sd_setImage(with: URL(string: obj.url), completed: nil)
        
    
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.connected(_:)))
            cell.photoImageView.isUserInteractionEnabled = true
            cell.photoImageView.tag = indexPath.row
            cell.photoImageView.addGestureRecognizer(tap)
       
        if(favoriteImage[indexPath.row] == true){
              cell.photoFavoriteImage.image = UIImage(named: "selected")
        }else{
            cell.photoFavoriteImage.image = UIImage(named: "notselected")
        }
        
return cell
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        cell.photoFavoriteImage.image = UIImage(named: "selected")
        favoriteImage[indexPath.row] = true
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = photoCollectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        cell.photoFavoriteImage.image = UIImage(named: "notselected")
        favoriteImage[indexPath.row] = false
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 322, height: 196)
    }
}
    



