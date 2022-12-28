//
//  DetailViewController.swift
//  PhotoProject
//
//  Created by Felix-ITS015 on 21/07/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var photoImageview: UIImageView!
    var str:String = ""
    var img:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        photoLabel?.text = str
        photoImageview.sd_setImage(with: URL(string: img), completed: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
