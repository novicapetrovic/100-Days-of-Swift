//
//  ViewController.swift
//  Project3
//
//  Created by Novica Petrovic on 28/02/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("country") {
                countries.append(item)
            }
        }
        print(countries)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {

            vc.selectedImage = countries[indexPath.row]
            vc.selectedImageNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

