//
//  LoadingViewController.swift
//  ForMonz
//
//  Created by Joan on 29/12/2016.
//  Copyright © 2016 Joan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class LoadingViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData() {
        
        var headers: HTTPHeaders = [:]
        
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaSI6Im9hdXRoY2xpZW50XzAwMDA5NFB2SU5ER3pUM2s2dHo4anAiLCJleHAiOjE0ODQ5NDQ5MDMsImlhdCI6MTQ4NDkyMzMwMywianRpIjoidG9rXzAwMDA5R2FUNXFLM0xYVlB6aUQwMkQiLCJ1aSI6InVzZXJfMDAwMDkyaUk1ZURTQUpLaTZ2eUtSdCIsInYiOiIyIn0.tHRZsK5mGrfTcMU4TKIY2eyzXwZ2Ul_7sUdKemgmJGw" // get users access Token
        let usersAccount = "acc_000092iI5eLbg0Fc41xkpt"
        let url = "https://api.monzo.com/transactions?expand[]=merchant&account_id=" + usersAccount
        
        headers["Authorization"] = "Bearer \(accessToken)"
        
        Alamofire.request(url, headers: headers)
            .responseJSON { response in
                //debugPrint(response)
                
                let json = response.result.value as? [String: Any]
                
                if let jsonForKey = json?["transactions"]{
                  
                  if let arrayyy = jsonForKey as? Array<AnyObject>{
                        let ja = Mapper<Transaction>().mapArray(JSONObject: arrayyy)
                    
                        let vc = HomeViewController()
                        vc.transactions = ja!
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
                if let jsonForKey = json?["message"]{
                    print(jsonForKey);
                 
                    if let messageString = jsonForKey as? String{
                        let alert: UIAlertController = UIAlertController(title: "Error", message: messageString, preferredStyle: .alert);
                        self.present(alert, animated: true, completion: nil);
                    }
                }
        }
 
    }
    

}
