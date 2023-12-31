//
//  SearchResultsViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(school: NYCSchool)
}

class SearchResultsViewController: UIViewController {
    var vm: NYCListViewModel = NYCListViewModel()
    weak var delegate: SearchResultsViewControllerDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NYCTableViewCell.self, forCellReuseIdentifier: NYCTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        Task {
            await vm.getAllNYCSchools()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension SearchResultsViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        vm.delegate = self
        
        vm.getNYCSchoolsCompletionHandler = { error in
            if error != nil {
                self.view.addSubview(self.tableView)
            } else {
            }
        }
    }
}

extension SearchResultsViewController: NYCSchoolListSearchDelegate {
    func searchSchoolsCompleted() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task {
            tableView.deselectRow(at: indexPath, animated: true)
            let school = self.vm.filteredNycSchools[indexPath.row]
            self.delegate?.searchResultsViewControllerDidTapItem(school: school)
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.filteredNycSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCTableViewCell.identifier, for: indexPath) as? NYCTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(nycSchool: vm.filteredNycSchools[indexPath.row], sortKey: vm.sortkey)
        
        return cell
    }
}
