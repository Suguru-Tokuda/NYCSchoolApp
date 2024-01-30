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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sort Direction"
        return label
    }()

    private var ascBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(SortOrder.asc.rawValue, for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.setImage(UIImage(systemName: "arrow.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        
        return btn
    }()
    
    private var dscBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(SortOrder.dsc.rawValue, for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.setImage(UIImage(systemName: "arrow.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.systemBlue.cgColor

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
            ascBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            ascBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ascBtn.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -padding),
            ascBtn.heightAnchor.constraint(equalToConstant: height)
        ]
        
        let dscBtnConstraints = [
            dscBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            dscBtn.leadingAnchor.constraint(equalTo: centerXAnchor, constant: padding),
            dscBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            dscBtn.heightAnchor.constraint(equalToConstant: height)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(ascBtnConstraints)
        NSLayoutConstraint.activate(dscBtnConstraints)
    }
    
    func setSelectedValue(sortOrder: SortOrder) {
        switch sortOrder {
        case .asc:
            ascBtn.layer.backgroundColor = UIColor.systemBlue.cgColor
            ascBtn.setTitleColor(.white, for: .normal)
            dscBtn.layer.backgroundColor = UIColor.clear.cgColor
            dscBtn.setTitleColor(.label, for: .normal)
        case .dsc:
            dscBtn.layer.backgroundColor = UIColor.systemBlue.cgColor
            dscBtn.setTitleColor(.white, for: .normal)
            ascBtn.layer.backgroundColor = UIColor.clear.cgColor
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
