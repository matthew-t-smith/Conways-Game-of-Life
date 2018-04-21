//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Matthew Smith on 12/4/17.
//  Copyright © 2017 Harvard University. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, GridViewDataSource, EngineDelegate, UITextFieldDelegate {
    
    var engine: StandardEngine = StandardEngine.engine
    let app = UIApplication.self

    @IBOutlet weak var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine.delegate = self
        gridView?.gridDataSource = self
        let defaults = UserDefaults.standard
        if let config = defaults.value(forKey: "savedGame") as? GridConfiguration {
            for val in config.contents {
                print(val)
            }
        }
        
        let center = NotificationCenter.default
        let updateName = Notification.Name(rawValue: "EngineUpdate")
        let sizeName = Notification.Name(rawValue: "EngineSize")
        center.addObserver(
            self,
            selector: #selector(engineUpdate(notification:)),
            name: updateName,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(engineUpdate(notification:)),
            name: sizeName,
            object: nil
        )
    }
    
    func engineDidUpdate(engine: EngineProtocol) {
        gridView.setNeedsDisplay()
    }
    
    @objc func engineUpdate(notification: Notification) {
        gridView.setNeedsDisplay()
    }
    
    var size: Int {
        return engine.size
    }
    
    subscript(row: Int, col: Int) -> CellState {
        get {
            return engine.grid[(row, col)]
        }
        set {
            engine.grid[(row,col)] = newValue
        }
    }
    
    @IBAction func step(_ sender: Any) {
        _ = engine.step()
        gridView.setNeedsDisplay()
    }
    
//    @IBAction func gridSave(_ sender: UIButton) {
//        var savedGame = GridConfiguration(title: "", contents: [])
//        savedGame.title = "Last Saved Game"
//        var aliveHolder: [[Int]] = []
//        var bornHolder: [[Int]] = []
//        for pos in engine.grid.alive {
//            aliveHolder.append([pos.row, pos.col])
//        }
//        for pos in engine.grid.born {
//            bornHolder.append([pos.row, pos.col])
//        }
//        for a in aliveHolder {
//            savedGame.contents.append(a)
//        }
//        for b in bornHolder {
//            savedGame.contents.append(b)
//        }
//        let recode = try! JSONEncoder().encode(savedGame)
//        let defaults = UserDefaults.standard
//        defaults.set(recode, forKey: "simulationConfiguration")
//    }
    
    @IBAction func gridReset(_ sender: UIButton) {
        let grid: Grid = Grid(engine.size, engine.size)
        engine.grid = grid
        gridView.setNeedsDisplay()
        
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineReset")
        let n = Notification(name: name,
                             object: nil,
                             userInfo: ["engine" : self])
        nc.post(n)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
