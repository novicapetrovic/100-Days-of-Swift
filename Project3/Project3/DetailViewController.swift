//
//  DetailViewController.swift
//  Project3
//
//  Created by Novica Petrovic on 28/02/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var countryImage: UIImageView!
    var selectedImage: String?
    var selectedImageNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Country"
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            countryImage.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped() {
        guard let image = countryImage.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }

        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
