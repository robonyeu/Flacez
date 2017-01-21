//
//  MonzoLoginViewController.swift
//  ForMonz
//
//  Created by Joan Cardona on 11/01/17.
//  Copyright © 2017 Joan. All rights reserved.
//

import UIKit

class MonzoLoginViewController: UIViewController {

    var state: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = randomString(length: 8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
 
     "https://auth.getmondo.co.uk/?
     client_id=$client_id&
     redirect_uri=$redirect_uri&
     response_type=code&
     state=$state_token"
     
     */
    

    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    @IBAction func monzoLoginTapped(_ sender: AnyObject) {
        
        let stringURL = "https://auth.getmondo.co.uk/?client_id=oauthclient_00009GI8qie279LfSMFBuT&redirect_uri=flacez://authorized&response_type=code&state=\(state)"
        
        let url = URL(string: stringURL)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    
    }

}
