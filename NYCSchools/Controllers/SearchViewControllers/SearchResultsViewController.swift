//
//  SearchResultsViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(school: NYCHighSchool)
}

class SearchResultsViewController: UIViewController {
    var vm: NYCListViewModel = NYCListViewModel()
    var delegate: SearchResultsViewControllerDelegate?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NYCTableViewCell.self, forCellReuseIdentifier: NYCTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        Task {
            await vm.getAllNYCHighSchools()
            print(vm.nycHighSchools.count)
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
        
        vm.getNYCHighSchoolsCompletionHandler = { error in
            if error != nil {
                self.view.addSubview(self.tableView)
            } else {
            }
        }
    }
}

extension SearchResultsViewController: NYCHighschoolListSearchDelegate {
    func searchHighschoolsCompleted() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task {
            let school = self.vm.filteredNycHighSchools[indexPath.row]
            self.delegate?.searchResultsViewControllerDidTapItem(school: school)
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.filteredNycHighSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCTableViewCell.identifier, for: indexPath) as? NYCTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(nycHighschool: vm.filteredNycHighSchools[indexPath.row])
        
        return cell
    }
}
