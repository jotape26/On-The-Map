//
//  TableViewController.swift
//  On The Map
//
//  Created by João Leite on 06/01/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var studentPins: NSArray = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let studentPins = appDelegate.studentPins {
            self.studentPins = studentPins
            tableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(populateScreen), name: .studentDataDownloaded, object: nil)
    }
    
    @objc func populateScreen(){
        if let studentPins = appDelegate.studentPins {
            self.studentPins = studentPins
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }

}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentPins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell", for: indexPath)
        
        let currentPin = studentPins[indexPath.row] as! NSDictionary
        cell.textLabel?.text = currentPin["firstName"] as? String
        return cell
    }
    
    
}