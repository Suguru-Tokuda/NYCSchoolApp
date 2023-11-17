//
//  FilterByView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/16/23.
//

import UIKit

class FilterByView: UIView {
    private var selectedOption: NYCSchoolSortKey = .graduationRate
    private var keyOptionDict: [NYCSchoolSortKey : UIButton] = [:]
    var selectionChange: ((NYCSchoolSortKey) -> ())?
    
    private var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Sort By"
        return label
    }()
    
    private var stackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func createBtn() -> NYCSchoolOderByFieldButton {
        let btn = NYCSchoolOderByFieldButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.setTitleColor(.label, for: .normal)
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return btn
    }
    
    deinit {
        stackView.subviews.forEach { stackView.removeArrangedSubview($0) }
        stackView = nil
        titleLabel = nil
    }
}

extension FilterByView {
    private func setupUI() {
        keyOptionDict = [:]
        addSubview(titleLabel)
        addSubview(stackView)
        
        var buttonContainer: UIView?
        let count = NYCSchoolSortKey.allCases.count
    
        for i in 0..<count {
            if i % 2 == 0 {
                buttonContainer = UIView()
                buttonContainer?.translatesAutoresizingMaskIntoConstraints = false
                buttonContainer?.heightAnchor.constraint(equalToConstant: 50).isActive = true
            }
            
            let option = NYCSchoolSortKey.allCases[i]
            addOptionBtnToStack(option: option, view: &buttonContainer!)
            
            if i % 2 == 1 || i == count - 1 {
                stackView.addArrangedSubview(buttonContainer!)
            }
        }

        applyConstraints()
    }
    
    private func addOptionBtnToStack(option: NYCSchoolSortKey, view: inout UIView) {
        let btn = createBtn()
        btn.setTitle(option.rawValue, for: .normal)
        btn.addTarget(self, action: #selector(handleBtnTap(_ :)), for: .touchUpInside)
        btn.orderByField = option
        btn.titleLabel?.textColor = selectedOption == option ? .white : .label
        
        keyOptionDict[option] = btn
        view.addSubview(btn)
    }
    
    private func applyConstraints() {
        let padding: CGFloat = 10
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        ]
        
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        
        for i in 0..<keyOptionDict.count {
            guard let btn = keyOptionDict[NYCSchoolSortKey.allCases[i]] else { break }
            btn.titleLabel?.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            if i % 2 == 0 {
                btn.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
                btn.trailingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: -padding).isActive = true
            } else {
                btn.leadingAnchor.constraint(equalTo: stackView.centerXAnchor, constant: padding).isActive = true
                btn.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -padding).isActive = true
            }
        }
    }
}

extension FilterByView {
    func setSelectedValue(sortKey: NYCSchoolSortKey) {
        self.selectedOption = sortKey
        keyOptionDict.forEach { (key, btn) in
            btn.layer.backgroundColor = (key == sortKey ? UIColor.systemBlue : UIColor.clear).cgColor
            btn.setTitleColor(key == sortKey ? .white : .label, for: .normal)
        }
    }
}

extension FilterByView {
    @objc private func handleBtnTap(_ sender: NYCSchoolOderByFieldButton) {
        selectedOption = sender.orderByField
        setSelectedValue(sortKey: sender.orderByField)
        selectionChange?(sender.orderByField)
    }
}
