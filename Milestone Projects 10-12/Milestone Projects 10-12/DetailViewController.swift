//
//  DetailViewController.swift
//  Milestone Projects 10-12
//
//  Created by Novica Petrovic on 10/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageLabel: UILabel!

    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail View Controller"

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
}
