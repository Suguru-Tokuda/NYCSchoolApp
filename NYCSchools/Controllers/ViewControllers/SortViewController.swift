//
//  SortViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/16/23.
//

import UIKit

class SortViewController: UIViewController {
    var vm: NYCSchoolSortViewModel! = NYCSchoolSortViewModel()
    var sortOptionApply: (((NYCSchoolSortKey, SortOrder)) -> ())?
    
    private lazy var scrollView: UIScrollView! = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var sortOrderOptionView: SortOrderView! = {
        let view = SortOrderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var filterByView: FilterByView! = {
        let view = FilterByView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SortViewController {
    func configure(sortKey: NYCSchoolSortKey, sortOrder: SortOrder) {
        vm.setValues(sortKey: sortKey, sortOrder: sortOrder)
        sortOrderOptionView.setSelectedValue(sortOrder: sortOrder)
        filterByView.setSelectedValue(sortKey: sortKey)
    }
}

extension SortViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        tabBarController?.tabBar.isHidden = true
        setupNavigationBar()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(sortOrderOptionView)
        stackView.addArrangedSubview(filterByView)
        
        setupEventHandlers()
        applyConstraints()
    }
    
    private func setupEventHandlers() {
        sortOrderOptionView.selectionChange = {selection in
            self.vm.setSortOrder(sortOrder: selection)
        }
        
        filterByView.selectionChange = { selection in
            self.vm.setSortKey(sortKey: selection)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        title = "Sort"
        navigationItem.setHidesBackButton(true, animated: true)
        
        let dismissBtn = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(dismissBtnTapped))
        self.navigationItem.leftBarButtonItem = dismissBtn
        
        let applyBtn = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(applySort))
        self.navigationItem.rightBarButtonItem = applyBtn
    }
    
    private func applyConstraints() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let padding: CGFloat = 10
        
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -padding * 2)
        ]
        
        let stackViewContainerConstraints = [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
                
        let sortOrderOptionViewConstraints = [
            sortOrderOptionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            sortOrderOptionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            sortOrderOptionView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let filterByViewConstraints = [
            filterByView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            filterByView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            filterByView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(stackViewContainerConstraints)
        NSLayoutConstraint.activate(sortOrderOptionViewConstraints)
        NSLayoutConstraint.activate(filterByViewConstraints)
    }
}

extension SortViewController {
    @objc private func dismissBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
            
    @objc private func applySort() {
        self.sortOptionApply?(vm.getSelectionValues())
        self.navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
    }
}
