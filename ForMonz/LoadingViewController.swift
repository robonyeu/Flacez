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
        
        let accessToken = "XXXX" // get users access Token
        let usersAccount = "acc_XXXX"
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

        }
 
    }
    

}
