//
//  TableViewController.swift
//  Project4
//
//  Created by Novica Petrovic on 01/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    var websites = [String]()

    override func viewDidLoad() {
        title = "Website"
        navigationController?.navigationBar.prefersLargeTitles = true
        websites = ["apple.com", "hackingwithswift.com"]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
