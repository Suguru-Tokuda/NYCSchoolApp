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
    private let webView: WKWebView = WKWebView()
    
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
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        if !urlStr.isEmpty {
            if !urlStr.contains("https://") {
                urlStr = "https://\(urlStr)"
            }

            if let url = URL(string: urlStr) {
                webView.load(URLRequest(url: url))
            }
        }        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
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
