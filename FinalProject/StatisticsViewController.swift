//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Matthew Smith on 12/16/17.
//  Copyright © 2017 Harvard University. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    var engine: StandardEngine = StandardEngine.engine
    var empty: Int = 0
    var alive: Int = 0
    var born: Int = 0
    var died: Int = 0
    
    @IBOutlet weak var emptyCells: UILabel!
    @IBOutlet weak var aliveCells: UILabel!
    @IBOutlet weak var bornCells: UILabel!
    @IBOutlet weak var diedCells: UILabel!
    
    @IBAction func reset(_ sender: UIButton) {
        empty = engine.grid.empty.count
        alive = engine.grid.alive.count
        born = engine.grid.born.count
        died = engine.grid.died.count
        updateCounts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empty = engine.grid.empty.count
        alive = engine.grid.alive.count
        born = engine.grid.born.count
        died = engine.grid.died.count
        updateCounts()
        
        let center = NotificationCenter.default
        let nameReset = Notification.Name(rawValue: "EngineReset")
        let nameUpdate = Notification.Name(rawValue: "EngineUpdate")
        center.addObserver(
            self,
            selector: #selector(engineReset(notification:)),
            name: nameReset,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(engineUpdate(notification:)),
            name: nameUpdate,
            object: nil)

        // Do any additional setup after loading the view.
    }
    
    func updateCounts() {
        // set labels to current count variables
        emptyCells.text = String(empty)
        aliveCells.text = String(alive)
        bornCells.text = String(born)
        diedCells.text = String(died)
    }
    
    @objc func engineUpdate(notification: Notification) {
        empty += engine.grid.empty.count
        alive += engine.grid.alive.count
        born += engine.grid.born.count
        died += engine.grid.born.count
        updateCounts()
    }
    
    @objc func engineReset(notification: Notification) {
        empty = engine.grid.empty.count
        alive = engine.grid.alive.count
        born = engine.grid.born.count
        died = engine.grid.died.count
        updateCounts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
