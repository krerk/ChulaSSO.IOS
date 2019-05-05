//
//  ChulaSSOViewController.swift
//  sso
//
//  Created by Krerk Piromsopa on 5/5/19.
//  Copyright © 2019 Chulalongkorn University. All rights reserved.
//

import UIKit
import WebKit

class ChulaSSOViewController: UIViewController , WKURLSchemeHandler {
    
    var ssoDelegate:ChulaSSOProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let configuration = WKWebViewConfiguration()
        configuration.setURLSchemeHandler(self, forURLScheme: "chulasso")
        let wkWebView = WKWebView(frame: .zero,configuration:configuration)
        self.view = wkWebView
        
        let mURL:URL = URL(string: "https://account.it.chula.ac.th/login?serviceName=CPMobile&service=chulasso://local/")!
        let request:URLRequest = URLRequest(url: mURL)
        wkWebView.load(request)
    }
    
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        let components:URLComponents=URLComponents(string: urlSchemeTask.request.url!.absoluteString)!
        
        let ticket:String = (components.queryItems?.filter({$0.name=="ticket"}).first!.value)!
        print("ticket: ", ticket)
        //urlSchemeTask.didFinish()
        ssoDelegate?.recvTicket(ticket: ticket)
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        print("webView: stop");
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
