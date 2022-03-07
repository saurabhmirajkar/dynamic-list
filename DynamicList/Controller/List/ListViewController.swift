//
//  ListViewController.swift
//  DynamicList
//
//  Created by Saurabh Mirajkar on 06/03/22.
//

import UIKit

class ListViewController: UIViewController {
    
    var enteredURL: String = ""
    private var listTableView = UITableView()
    private var listItems: [ListItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupTableView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listTableView.frame = view.bounds
    }
        
    private func fetchData() {
        let listParser = ListParser()
        listParser.parseList(url: enteredURL) { listItems in
            self.listItems = listItems
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    fileprivate func setupNavigationView() {
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            navigationItem.compactAppearance = appearance
        }
    }
    
    fileprivate func setupTableView() {
        self.view.addSubview(listTableView)
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        listTableView.dataSource = self
        listTableView.delegate = self
    }

}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listItems = listItems else {
            return 0
        }
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        if let item = self.listItems?[indexPath.row] {
            cell.item = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
