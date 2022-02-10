//
//  ViewController.swift
//  RobloxLauncher
//
//  Created by Raymond Hsu on August 15th, 2021.
//

import Cocoa
import WebKit
import Foundation

typealias Callback = (NSEvent) -> ()

class ViewController: NSViewController, WKUIDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration ();
        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs");
        webView = WKWebView (frame: CGRect(x:0, y:0, width:1920, height:1080), configuration:webConfiguration);
        
        webView.navigationDelegate = self
        self.view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://www.roblox.com/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if var title = webView.title {
                let wordToRemove = "Roblox"
                if let range = title.range(of: wordToRemove) {
                   title.removeSubrange(range)
                }
                let removeCharacters: Set<Character> = ["-"]
                title.removeAll(where: { removeCharacters.contains($0) } )
                self.view.window?.subtitle = title
            }
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Check for links.
        if navigationAction.targetFrame == nil {
            // Make sure the URL is set.
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }
            // Check for the scheme component.
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            if components?.scheme == "http" || components?.scheme == "https" {
                // Open the link in the external browser.
                NSWorkspace.shared.open(url)
                // Cancel the decisionHandler because we managed the navigationAction.
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}
