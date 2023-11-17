//
//  SortOrderView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/16/23.
//

import UIKit

class SortOrderView: UIView {
    private var selectedOption: SortOrder = .asc
    var selectionChange: ((SortOrder) -> ())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sort Direction"
        return label
    }()

    private let ascBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(SortOrder.asc.rawValue, for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.titleLabel?.backgroundColor = .systemBackground
        btn.titleLabel?.layer.borderColor = UIColor.systemBlue.cgColor
        btn.titleLabel?.layer.borderWidth = 1
        btn.titleLabel?.layer.cornerRadius = 5
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }()
    
    private let dscBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(SortOrder.dsc.rawValue, for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.titleLabel?.backgroundColor = .systemBackground
        btn.titleLabel?.layer.borderColor = UIColor.systemBlue.cgColor
        btn.titleLabel?.layer.borderWidth = 1
        btn.titleLabel?.layer.cornerRadius = 5
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SortOrderView {
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(ascBtn)
        addSubview(dscBtn)
        
        ascBtn.addTarget(self, action: #selector(ascBtnTap), for: .touchUpInside)
        dscBtn.addTarget(self, action: #selector(dscBtnTap), for: .touchUpInside)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let height: CGFloat = 50
        let padding: CGFloat = 10
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        ]
        
        let ascBtnConstraints = [
            ascBtn.titleLabel?.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            ascBtn.titleLabel?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ascBtn.titleLabel?.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -padding),
            ascBtn.titleLabel?.heightAnchor.constraint(equalToConstant: height)
        ]
        
        let dscBtnConstraints = [
            dscBtn.titleLabel?.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            dscBtn.titleLabel?.leadingAnchor.constraint(equalTo: centerXAnchor, constant: padding),
            dscBtn.titleLabel?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            dscBtn.titleLabel?.heightAnchor.constraint(equalToConstant: height)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        (ascBtnConstraints + dscBtnConstraints).forEach { constraint in
            if let constraint {
                NSLayoutConstraint.activate([constraint])
            }
        }
    }
    
    func setSelectedValue(sortOrder: SortOrder) {
        switch sortOrder {
        case .asc:
            ascBtn.titleLabel?.backgroundColor = .systemBlue
            ascBtn.setTitleColor(.white, for: .normal)
            dscBtn.titleLabel?.backgroundColor = .clear
            dscBtn.setTitleColor(.label, for: .normal)
        case .dsc:
            dscBtn.titleLabel?.backgroundColor = .systemBlue
            dscBtn.setTitleColor(.white, for: .normal)
            ascBtn.titleLabel?.backgroundColor = .clear
            ascBtn.setTitleColor(.label, for: .normal)
        }
    }
}

extension SortOrderView {
    @objc private func ascBtnTap() {
        setSelectedValue(sortOrder: .asc)
        selectionChange?(.asc)
    }
    
    @objc private func dscBtnTap() {
        setSelectedValue(sortOrder: .dsc)
        selectionChange?(.dsc)
    }
}
