//
//  ViewController.swift
//  Sample
//
//  Created by Hinagiku Soranoba on 2019/12/01.
//  Copyright © 2019 Hinagiku Soranoba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let identifier = "identifier"
    var tableViewItems: [Int] = []
    var collectionViewItems: [Int] = []

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.identifier)

        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(tableView)

        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.identifier)

        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(collectionView)

        tableViewItems = [1, 2]
        tableView.insertRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)],
                             with: .automatic)
        tableViewItems = [1]
        tableView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        tableViewItems = [2, 1]
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)

        let `case`: Int = 2
        switch `case` {
        case 1:
            collectionView.performBatchUpdates {
                collectionViewItems = [1, 2]
                collectionView.insertItems(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)])
            }
            collectionView.performBatchUpdates {
                collectionViewItems = [1]
                collectionView.deleteItems(at: [IndexPath(row: 1, section: 0)])
            }
        case 2:
            collectionViewItems = [1, 2]
            collectionView.insertItems(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)])

            collectionViewItems = [1]
            // attempt to delete item 1 from section 0 which only contains 1 items before the update
            collectionView.deleteItems(at: [IndexPath(row: 1, section: 0)])
        case 3:
            collectionViewItems = [1, 2]
            collectionView.insertItems(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)])

            collectionViewItems = [1]
            if collectionView.hasUncommittedUpdates {
                collectionView.reloadData()
            } else {
                // attempt to delete item 1 from section 0 which only contains 1 items before the update
                collectionView.deleteItems(at: [IndexPath(row: 1, section: 0)])
            }
        default:
            break
        }
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Self.identifier, for: indexPath)
    }
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Self.identifier, for: indexPath)
    }
}
