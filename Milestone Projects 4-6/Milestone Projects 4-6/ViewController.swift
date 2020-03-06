//
//  ViewController.swift
//  Milestone Projects 4-6
//
//  Created by Novica Petrovic on 05/03/2020.
//  Copyright © 2020 Novica Petrovic. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToBasket))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(removeFromBasket))

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

    @objc func addToBasket() {
        let ac = UIAlertController(title: "Enter an item", message: "Enter what you'd like to add to your basket", preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Add to Basket", style: .default) {
            [weak self, weak ac] _ in
            guard let input = ac?.textFields?[0].text else { return }
            self?.submit(item: input)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(item: String) {
        shoppingList.append(item)
        let indexPath = IndexPath(row: shoppingList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @objc func removeFromBasket() {
        shoppingList.popLast()
        tableView.reloadData()
    }
}

