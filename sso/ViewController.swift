//
//  ViewController.swift
//  sso
//
//  Created by Krerk Piromsopa on 5/5/19.
//  Copyright © 2019 Chulalongkorn University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ChulaSSOProtocol {
    
    let DeeAppId:String = "DEE APP ID"
    let DeeAppSecret:String = "DEE APP SECRET"
    
    var ticket:String? = nil
    
    @IBOutlet var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func connectWithSSO(_ sender: Any) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest:ChulaSSOViewController = segue.destination as! ChulaSSOViewController
        dest.ssoDelegate=self
        
    }
    
    func recvTicket(ticket: String) {
        //print("Ticket", ticket)
        let stURL="https://account.it.chula.ac.th/serviceValidation"
        let url:URL = URL(string: stURL)!
        var request:URLRequest = URLRequest(url: url)
        
        request.httpMethod="POST"
        request.addValue(DeeAppId, forHTTPHeaderField: "DeeAppId")
        request.addValue(DeeAppSecret, forHTTPHeaderField: "DeeAppSecret")
        request.addValue(ticket, forHTTPHeaderField: "DeeTicket")
        
        let task=URLSession.shared.dataTask(with: request) { (data, response, err) in
            guard let data = data else { return }
            //let jsonString:String = String(data:data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print(String(data:data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) as Any)
            var obj = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            DispatchQueue.main.async {
                self.myLabel.text = obj!["username"]! as? String
            }
            
        }
        task.resume()
        
    }
    
}
