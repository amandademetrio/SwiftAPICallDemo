//
//  PeopleViewController.swift
//  StarWarsEnciclopedia
//
//  Created by Amanda Demetrio on 9/15/18.
//  Copyright © 2018 Amanda Demetrio. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {

    var people: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // specify the url that we will be sending the GET Request to
        let url = URL(string: "http://swapi.co/api/people/")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run the completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        resultsArray.forEach{ element in
                            self.people.append((element as? NSDictionary)!)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        })
        // execute the task and wait for the response before
        // running the completion handler. This is async!
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = people[indexPath.row]["name"] as! String
        return cell
    }

}
