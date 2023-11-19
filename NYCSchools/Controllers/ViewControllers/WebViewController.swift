//
//  WebViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/15/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var urlStr: String = ""
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    init(urlStr: String) {
        super.init(nibName: nil, bundle: nil)
        self.urlStr = urlStr
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if !urlStr.isEmpty {
            if !urlStr.contains("http") {
                urlStr = "https://\(urlStr)"
            }

            if let url = URL(string: urlStr) {
                webView.load(URLRequest(url: url))
            }
        }        
    }
}

extension WebViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        tabBarController?.tabBar.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handlePageLoadError()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handlePageLoadError()
    }
    
    func handlePageLoadError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error loading the page", message: "Could not load \(self.urlStr)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
}
