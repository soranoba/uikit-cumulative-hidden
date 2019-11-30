//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private var allCells: [UITableViewCell] = []
    private var currentCells: [UITableViewCell] = []

    // MARK: - Lifecycle

    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        allCells = (0..<100).map { _ in UITableViewCell(style: .default, reuseIdentifier: nil) }
        allCells[0].isHidden = true
        allCells[1].isHidden = true
        allCells[2].isHidden = true
        reload()

        navigationItem.rightBarButtonItems = [
            .init(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit(_:)))
        ]
    }

    // MARK: - Methods

    @objc private func didTapEdit(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Edit", message: "What number do you want to add or remove?", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(.init(title: "Add", style: .default, handler: { [weak alert] _ in
            guard let text = alert?.textFields?[0].text, let num = Int(text) else {
                print("failed to add cell")
                return
            }
            self.addCell(num: num)
        }))
        alert.addAction(.init(title: "Remove", style: .destructive, handler: { [weak alert] _ in
            guard let text = alert?.textFields?[0].text, let num = Int(text) else {
                print("failed to remove cell")
                return
            }
            self.removeCell(num: num)
        }))
        present(alert, animated: true, completion: nil)
    }

    private func addCell(num: Int) {
        if allCells.indices.contains(num) {
            allCells[num].isHidden = false
            reload()
        }
    }

    private func removeCell(num: Int) {
        if allCells.indices.contains(num) {
            allCells[num].isHidden = true
            reload()
        }
    }

    private func reload() {
        currentCells = allCells.filter { !$0.isHidden }
        tableView.reloadData()
    }

    // MARK: - UITableViewController (Overrides)

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currentCells[indexPath.row]
        cell.textLabel?.text = "\(allCells.firstIndex(of: cell)!)"
        return cell
    }
}
