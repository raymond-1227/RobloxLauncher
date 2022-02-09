//  ViewController.swift
//  RobloxLauncher
//
//  Created by Raymond Hsu on August 15th, 2021.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKUIDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration ();
        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs");
        webView = WKWebView (frame: CGRect(x:0, y:0, width:1920, height:1080), configuration:webConfiguration);
        webView.uiDelegate = self;
        self.view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://www.roblox.com/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
}
