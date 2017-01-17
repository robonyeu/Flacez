//
//  HomeViewController.swift
//  ForMonz
//
//  Created by Joan on 29/12/2016.
//  Copyright © 2016 Joan. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var transactions:[Transaction] = []
    var merchants:[Merchant] = []
    var orderedTags:Array<String> = []
    var tagsAndCounts:[String:Int] = [:]
    var similarVenues: Array<Venue> = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getMerchants()
        lookForPriorityTags()
    }
    
    func getMerchants() {
        
        let buildingMerchants = NSMutableArray()
        
        for transaction:Transaction in transactions{
            
            if let merchant = transaction.merchant {
                buildingMerchants.add(merchant)
            }
        }
        
        merchants = buildingMerchants.copy() as! [Merchant]
    }
    
    func lookForPriorityTags() {
        // one day we will get a time range to look for tags
        
        var tags: Array<String> = []
        var usefulMerchants: Array<Merchant> = []

        for merchant:Merchant in merchants{
            
            if let tt = merchant.metadata?.tags{
                let allTagsArray = tt.characters.split{$0 == " "}.map(String.init)
                
                if(allTagsArray.contains("#food") || allTagsArray.contains("#pub") || allTagsArray.contains("#drinks") || allTagsArray.contains("#fun")){
                    usefulMerchants.append(merchant);
                   
                    if let id = merchant.metadata?.foursquareID {
                        searchForVenueWithID(venueID: id)
                    }
                }
                
                for tag: String in allTagsArray{
                    tags.append(tag)
                }
            }
        }

        
        var counts:[String:Int] = [:]
        
        for item in tags {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        tagsAndCounts = counts
        
        var keys = Array(counts.keys)
        keys.sort { (o1, o2) -> Bool in
            return counts[o1]! as! Int > counts[o2]! as! Int
        }
        orderedTags = keys
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func merchantsTapped(_ sender: Any) {
        let vc = MerchantsViewController()
        vc.merchants = merchants
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarVenues.count//orderedTags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        let venue: Venue = similarVenues[indexPath.row]
        cell?.textLabel?.text = venue.name
      
        var location = ""
        if let formatAddress = venue.location?["formattedAddress"] as? Array<String> {

            for add: String in formatAddress{
                location.append(" \(add)")
            }
        }

        cell?.detailTextLabel?.text = location

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let range: Range<String.Index> = orderedTags[indexPath.row].range(of: "#")!
       // let key = orderedTags[indexPath.row].substring(from: range.upperBound)
        //searchVenueWithQuery(query: key)
        let venue:Venue = similarVenues[indexPath.row]
        
        if let name = venue.location?["formattedAddress"] as? Array<String> {
            print(name)
        }
     
        
    }
    
    
    //MARK: Foursquare 
    
    func searchVenueWithQuery(query: String){
        
        let query = "q=" + query
        let location = "ll=40.7,-74"
        let versioning = "v=20161220&m=foursquare"
        let baseURL = "https://api.foursquare.com/v2/venues/search?"
        let basics = baseURL + location + "&" + versioning
        let keys = "&client_id=" + "NV1G1RCI03QPITX3KOK3RIXF1KBOQ3VXTCMICGHJJDQKZV5B" + "&client_secret=" + "O5JJOBCUNMV0WGEUBLSUZHPZ32OA2TNDYPXLZSNN5HWEHVNX"
        
        Alamofire.request(basics + keys + "&" + query).responseJSON { response in
            print(response)
        }
    }
    
    func searchForVenueWithID(venueID:String){
        
        let versioning = "&v=20161220&m=foursquare"
        let baseURL = "https://api.foursquare.com/v2/venues/"
        let keys = "client_id=" + "NV1G1RCI03QPITX3KOK3RIXF1KBOQ3VXTCMICGHJJDQKZV5B" + "&client_secret=" + "O5JJOBCUNMV0WGEUBLSUZHPZ32OA2TNDYPXLZSNN5HWEHVNX" + versioning
        
        Alamofire.request(baseURL + "/" + venueID + "/similar?" + keys).responseJSON { response in
            
            let json = response.result.value as? [String: Any]

            if let jsonForResponse = json?["response"]{
                
                if let jsonForVenues = jsonForResponse as? [String: Any]{
                    
                    if let sim = jsonForVenues["similarVenues"]{
                        
                        if let simVenues = sim as? [String: Any]{

                            if let arrayItems = simVenues["items"]{
                                
                                if let arrayyy = arrayItems as? Array<AnyObject>{
                                    let venues = Mapper<Venue>().mapArray(JSONObject: arrayyy)
                                    self.similarVenues += venues!
                                }
                            }

                        }

                    }
                    
                }
            }

            self.tableView.reloadData()
            
        }
        
    }

}
