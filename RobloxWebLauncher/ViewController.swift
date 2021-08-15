//  ViewController.swift
//  RobloxWebLauncher
//
//  Created by Raymond Hsu on August 15th, 2021.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKUIDelegate
    {
    var webView: WKWebView!

    override func loadView()
        {
        let webConfiguration = WKWebViewConfiguration ();
        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs");
        webView = WKWebView (frame: CGRect(x:0, y:0, width:1920, height:1080), configuration:webConfiguration);
        webView.uiDelegate = self;
        view = webView;
        }

    override func viewDidLoad() {
    super.viewDidLoad()
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.webView.frame.size.height))
        self.view.addSubview(webView)
        let url = URL(string: "https://www.roblox.com")
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
            // Do any additional setup after loading the view.
        }
    }

