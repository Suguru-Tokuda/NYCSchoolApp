//
//  NYCListViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import UIKit

class NYCListViewController: UIViewController, UISearchControllerDelegate {
    var vm: NYCListViewModel = NYCListViewModel()
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search..."
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
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
            await vm.getNYCSchools()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = view.bounds
    }
}

extension NYCListViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = self.searchController
        navigationController?.navigationBar.tintColor = .white
        searchController.searchResultsUpdater = self
        if let searchResultVC = searchController.searchResultsController as? SearchResultsViewController {
            searchResultVC.delegate = self
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        vm.getNYCSchoolsCompletionHandler = { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                
            }
        }
    }
    
    private func navigateToDetailsView(school: NYCSchool) {
        Task {
            let detailsVC = NYCSchoolDetailViewController()
            detailsVC.vm.getNYCScoreDataHandler = { [weak self] error in
                if error != nil {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error Fetching School Data", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self?.present(alert, animated: true)
                    }
                }
            }

            if let scoreData = await detailsVC.vm.getNYCScoreData(id: school.id) {
                DispatchQueue.main.async {
                    detailsVC.configure(school: school, scoreData: scoreData)
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
            }
        }
    }
}

extension NYCListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.nycSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCTableViewCell.identifier, for: indexPath) as? NYCTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(nycSchool: vm.nycSchools[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == vm.nycSchools.count {
            Task {
                await vm.getNYCSchools()
            }
        }
    }
}

extension NYCListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToDetailsView(school: self.vm.nycSchools[indexPath.row])
    }
}

extension NYCListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let vc = searchController.searchResultsController as? SearchResultsViewController {
            if let searchText = searchController.searchBar.text {
                vc.vm.searchNYCSchools(searchText: searchText)
            }
        }
    }
}

extension NYCListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidTapItem(school: NYCSchool) {
        navigateToDetailsView(school: school)
    }
}
