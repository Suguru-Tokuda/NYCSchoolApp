//
//  NYCListViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import UIKit

class NYCListViewController: UIViewController, UISearchControllerDelegate {
    var vm: NYCListViewModel! = NYCListViewModel()
    var sortVC: SortViewController?
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search by school name and address"
        return controller
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // register cells
        tableView.register(NYCTableViewCell.self, forCellReuseIdentifier: NYCTableViewCell.identifier)
        tableView.register(NYCSchoolTableLoadingViewCell.self, forCellReuseIdentifier: NYCSchoolTableLoadingViewCell.identifier)
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
        seupUIAfterViewDiLayoutSubviews()
    }
        
    deinit {
        vm = nil
    }
}

extension NYCListViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .white
        searchController.searchResultsUpdater = self
        if let searchResultVC = searchController.searchResultsController as? SearchResultsViewController {
            searchResultVC.delegate = self
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tabBarController?.delegate = self
        view.addSubview(tableView)
        
        vm.getNYCSchoolsCompletionHandler = { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.showErrorAlert(error: error!)
            }
        }
    }
    
    private func navigateToDetailsView(school: NYCSchool) {
        Task {
            let detailsVC = NYCSchoolDetailViewController()
            detailsVC.vm.getNYCScoreDataHandler = { [weak self] error in
                if error != nil {
                    self?.showErrorAlert(error: error!)
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
    
    private func showErrorAlert(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error Fetching School Data", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

extension NYCListViewController {
    func seupUIAfterViewDiLayoutSubviews() {
        self.tableView.frame = view.bounds
        
        let filterBtn = UIButton()
        filterBtn.imageView?.tintColor = .systemGray
        filterBtn.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        filterBtn.addTarget(self, action: #selector(filterBtnTap), for: .touchUpInside)
        searchController.searchBar.searchTextField.rightView = filterBtn
        searchController.searchBar.searchTextField.rightViewMode = .always
        searchController.searchBar.searchTextField.delegate = self
    }
    
    @objc private func filterBtnTap() {
        sortVC = SortViewController()
        sortVC?.configure(sortKey: vm.sortkey, sortOrder: vm.sortOrder)
        navigationController?.pushViewController(sortVC!, animated: true)
        
        sortVC?.sortOptionApply = { [weak self] value in
            Task {
                await self?.vm.resetAndGetSchools(sortKey: value.0, sortOrder: value.1)
                self?.scrollToTop()
            }
        }
    }
}

extension NYCListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return vm.nycSchools.count
        case 1:
            return vm.isLoading ? 1 : 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCTableViewCell.identifier, for: indexPath) as? NYCTableViewCell else {
                return UITableViewCell()
            }
            
            if vm.nycSchools.count > indexPath.row {
                cell.configure(nycSchool: vm.nycSchools[indexPath.row], sortKey: vm.sortkey)
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCSchoolTableLoadingViewCell.identifier, for: indexPath) as? NYCSchoolTableLoadingViewCell else {
                return UITableViewCell()
            }
            
            cell.setupUI()
                        
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row + 1 == vm.nycSchools.count {
            Task {
                await vm.getNYCSchools()
            }
        }
    }
}

extension NYCListViewController: UITableViewDelegate {   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            navigateToDetailsView(school: self.vm.nycSchools[indexPath.row])
        }
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

extension NYCListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchController.searchBar.searchTextField.rightView?.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchController.searchBar.searchTextField.rightView?.isHidden = false
    }
}

extension NYCListViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let vc = viewController as? CustomNavigationController,
           vc.identifier == "NYCListViewController",
           let sortVC {
            sortVC.navigationController?.popViewController(animated: false)
        }
    }
}

extension NYCListViewController {
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topRow, at: .top, animated: false)
    }
}
