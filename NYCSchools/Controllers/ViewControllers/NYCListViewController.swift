//
//  NYCListViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import UIKit

class NYCListViewController: UIViewController {
    var vm: NYCListViewModel = NYCListViewModel()
    
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
            await vm.getNYCHighSchools()
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension NYCListViewController {
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        vm.getNYCHighSchoolsCompletionHandler = { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                
            }
        }
    }
}

extension NYCListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.nycHighSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NYCTableViewCell.identifier, for: indexPath) as? NYCTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(nycHighschool: vm.nycHighSchools[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == vm.nycHighSchools.count {
            Task {
                await vm.getNYCHighSchools()
            }
        }
    }
}

extension NYCListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let school = self.vm.nycHighSchools[indexPath.row]
            
            
            print(school)
            
            let detailsVC = NYCHighSchoolDetailViewController()
            detailsVC.setSchool(school: school)
            
            print(detailsVC)
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
