//
//  HomepageURLView.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/15/23.
//

import UIKit

class HomepageURLView: UIView {
    var linkTapped: ((String) -> ())?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Homepage"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private var urlBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.titleLabel?.textColor = .systemBlue
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.translatesAutoresizingMaskIntoConstraints = false
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

extension HomepageURLView {
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        addSubview(urlBtn)
        
        urlBtn.addTarget(self, action: #selector(handleUrlLabelTap), for: .touchUpInside)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let viewConstraints = [
            heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        let urlBtnCostraints = [
            urlBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            urlBtn.leadingAnchor.constraint(equalTo: leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(viewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(urlBtnCostraints)
    }
    
    func configure(urlStr: String) {
        urlBtn.setTitle(urlStr, for: .normal)
    }
}

extension HomepageURLView {
    @objc private func handleUrlLabelTap() {
        if let text = urlBtn.titleLabel?.text {
            linkTapped?(text)
        }
    }
}
