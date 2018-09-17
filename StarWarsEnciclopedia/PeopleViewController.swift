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
        
        //After MVC refactoring
        StarWarsModel.getAllPeople(completionHandler: {
            // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for person in results {
                            let personDict = person as! NSDictionary
                            self.people.append(personDict)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(self.people)
                }
            } catch {
                print("Something went wrong")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PeopleDetailViewController
        let indexPath = sender as! IndexPath
        destination.name = people[indexPath.row]["name"] as? String
        destination.gender = people[indexPath.row]["gender"] as? String
        destination.birthYear = people[indexPath.row]["birth_year"] as? String
        destination.mass = people[indexPath.row]["mass"] as? String
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = people[indexPath.row]["name"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PeopleDetailSegue", sender: indexPath)
    }

}
