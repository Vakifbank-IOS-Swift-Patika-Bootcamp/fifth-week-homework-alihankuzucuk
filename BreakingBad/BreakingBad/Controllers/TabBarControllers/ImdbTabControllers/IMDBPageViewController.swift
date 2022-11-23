//
//  IMDBPageViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import UIKit
import WebKit

final class IMDBPageViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var webview: WKWebView!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let breakingBadUrl = "https://www.imdb.com/title/tt0903747/"
        if let url = URL(string: breakingBadUrl) {
            webview.navigationDelegate = self
            webview.load(URLRequest(url: url))
        }
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }

}

extension IMDBPageViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = "IMDB - Breaking Bad"
    }
}
