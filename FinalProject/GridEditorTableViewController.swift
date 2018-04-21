//
//  GridEditorTableViewController.swift
//  FinalProject
//
//  Created by Matthew Smith on 12/4/17.
//  Copyright © 2017 Harvard University. All rights reserved.
//

import UIKit

class GridEditorTableViewController: UITableViewController {
    
    //Expired (noted: 4/18/18)
    //var config = URL(string: "https://www.dropbox.com/s/p6iad4piknaja3p/S65g.json?dl=1")
    //Updated
    //var config = URL(string: "https://1drv.ms/u/s!AqopmsYkll3sh6xvPvnucXhOX7XrdA")
    
    var configData:[GridConfiguration]?
    var titles: [String] = []
    var data: [[[Int]]] = []

//    func fetcherUpdate() {
//        let fetcher = Fetcher()
//        fetcher.fetch(url: config!) { (result) in
//            var resultString = ""
//            switch result {
//                case .success(let data):
//                    let decoder = JSONDecoder()
//                    self.configData = try! decoder.decode([GridConfiguration].self, from: data)
//                    for val in self.configData! {
//                        self.titles.append(val.title)
//                        self.data.append(val.contents)
//                    }
//                    resultString = (self.configData?.description)!
//                case .failure(let message):
//                    resultString = message
//                    print(resultString)
//            }
//            OperationQueue.main.addOperation {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetcherUpdate()
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, IndexPath) in
//            self.configData[IndexPath.section].remove(at: IndexPath.row)
//            tableView.reloadData()
//        }
//        return [delete]
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if configData == nil {
            return 0
        } else {
            return titles[section].count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = "Grid"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        print(indexPath.section)
        cell.textLabel?.text = titles[indexPath.section]
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let editor = segue.destination as? GridEditorViewController {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let tableValue = titles[indexPath.section]
//                //editor.grid = tableValue
//                editor.saveClosure = { newValue in
//                    //self.data[indexPath.section][indexPath.row] = newValue
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
