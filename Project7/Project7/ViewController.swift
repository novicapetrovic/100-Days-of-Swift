//
//  ViewController.swift
//  Project7
//
//  Created by Novica Petrovic on 05/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var backUpPetitions = [Petition]()
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))

        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

        showError()
    }

    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            backUpPetitions = jsonPetitions.results
            petitions = backUpPetitions
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition  = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func showCredits() {
        let ac = UIAlertController(title: "Data Source", message: "This data is provided by WeThePeopleAPI from the whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    @objc func search() {
        let ac = UIAlertController(title: "Search Petitions", message: "Search for the petition you're looking for by adding keywords", preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak ac] _ in
            guard let input = ac?.textFields?[0].text else { return }
            self?.submit(keyword: input)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(keyword: String) {
        petitions = []

        for petition in backUpPetitions {
            if petition.title.lowercased().contains(keyword.lowercased()) || petition.body.lowercased().contains(keyword.lowercased()) {
                petitions.append(petition)
            }
        }
        tableView.reloadData()
    }
}
