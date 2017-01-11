//
//  MerchantsViewController.swift
//  ForMonz
//
//  Created by Joan on 29/12/2016.
//  Copyright © 2016 Joan. All rights reserved.
//

import UIKit
import Alamofire

class MerchantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var merchantsTableView: UITableView!
    var merchants:[Merchant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
    
        let merchant = merchants[indexPath.row]
        cell?.textLabel?.text = merchant.name
        print(merchant.metadata?.tags)

        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let merchant = merchants[indexPath.row]
        
        if let id = merchant.metadata?.foursquareID {
            searchForVenueWithID(venueID: id)
        }
    }

    func searchForVenueWithID(venueID:String){
        
        let versioning = "&v=20161220&m=foursquare"
        let baseURL = "https://api.foursquare.com/v2/venues/"
        let keys = "client_id=" + "NV1G1RCI03QPITX3KOK3RIXF1KBOQ3VXTCMICGHJJDQKZV5B" + "&client_secret=" + "O5JJOBCUNMV0WGEUBLSUZHPZ32OA2TNDYPXLZSNN5HWEHVNX" + versioning
        
        Alamofire.request(baseURL + "/" + venueID + "/similar?" + keys).responseJSON { response in
            print(response)
        }
    }

    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
