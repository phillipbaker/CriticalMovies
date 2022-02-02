//
//  WebView.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 12/10/21.
//

import UIKit
import WebKit

class WebView: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var webView: WKWebView!
    var url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeMe))
        navigationItem.rightBarButtonItem = doneButton

        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    @objc func closeMe() {
        dismiss(animated: true)
    }
}
