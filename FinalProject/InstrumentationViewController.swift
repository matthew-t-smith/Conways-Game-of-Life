//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Van Simmons on 6/5/17.
//  Copyright © 2017 Harvard University. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {

    var engine: StandardEngine = StandardEngine.engine
    var tableViewController: GridEditorTableViewController!
    
    @IBOutlet weak var gridSize: UITextField!
    @IBOutlet weak var refreshPeriod: UISlider!
    @IBOutlet weak var timedRefresh: UISwitch!
    @IBOutlet weak var gridSizeStep: UIStepper!
    @IBOutlet weak var refreshValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide unneccesary navigation bar in initial view
        navigationController?.navigationBar.isHidden = true
        gridSize.text = "\(engine.size)"
        if timedRefresh.isOn {
            refreshValue.text = String(rounded(Double(refreshPeriod.value), toNearest: 0.1)) + "sec"
        } else {
            refreshValue.text = "Off"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func gridSizeStepper(_ sender: UIStepper) {
        engine.size = Int(gridSizeStep.value)
        gridSize.text = "\(engine.size)"
    }
    
    @IBAction func gridSizeText(_ sender: UITextField) {
        if let stringVal = gridSize.text {
            if let intVal = Int(stringVal) {
                engine.size = intVal
            }
        } else {
        }
        gridSize.text = "\(engine.size)"
    }

    
    @IBAction func tapper(_ sender: UITapGestureRecognizer) {
        gridSize.resignFirstResponder()
    }
    
    @IBAction func refreshPeriodSlider(_ sender: UISlider) {
        refreshValue.text = String(rounded(Double(refreshPeriod.value), toNearest: 0.1)) + "sec"
        if timedRefresh.isOn {
            engine.refreshRate = Double(refreshPeriod.value)
        }
    }
    
    // credit to Joey Devilla at globalnerdy.com for this rounding helper function
    func rounded(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
    
    @IBAction func timedRefreshSwitch(_ sender: UISwitch) {
        if sender.isOn {
            engine.refreshRate = Double(refreshPeriod.value)
            refreshValue.text = String(rounded(Double(refreshPeriod.value), toNearest: 0.1)) + "sec"
        } else {
            refreshValue.text = "Off"
            engine.refreshRate = 0.0
            engine.refreshTimer?.invalidate()
            engine.refreshTimer = nil
        }
    }
    
    @IBAction func adder(_ sender: UIButton) {
//        tableViewController.data.append([[10, 10]])
//        tableViewController.tableView.reloadData()
    }

    @IBAction func deleter(_ sender: UIButton) {
        if tableViewController.data.count != 0 {
        tableViewController.data[0].remove(at: 0)
        if tableViewController.data[0].count == 0 {
            tableViewController.data.remove(at: 0)
        }
        if let indexPath = tableViewController.tableView?.indexPathForSelectedRow {
            tableViewController.data[indexPath.section].remove(at: indexPath.item)
        }
        tableViewController.tableView.reloadData()
        } else { }
    }

    @IBAction func fetcher(_ sender: UIButton) {
        //tableViewController.fetcherUpdate()
        tableViewController.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GridEditorTableViewController {
            tableViewController = vc
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

