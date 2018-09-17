//
//  FilmTableViewController.swift
//  StarWarsEnciclopedia
//
//  Created by Amanda Demetrio on 9/16/18.
//  Copyright © 2018 Amanda Demetrio. All rights reserved.
//

import UIKit

class FilmTableViewController: UITableViewController {
    
    var films: [NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://swapi.co/api/films/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        resultsArray.forEach{ element in
                            self.films.append((element as? NSDictionary)!)
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
    task.resume()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = films[indexPath.row]["title"] as! String
        return cell
    }

}
