//
//  GridEditorViewController.swift
//  FinalProject
//
//  Created by Matthew Smith on 12/4/17.
//  Copyright © 2017 Harvard University. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController, GridViewDataSource {

    var engine: StandardEngine = StandardEngine.engine
    var grid: Grid?
    var saveClosure: ((Grid) -> Void)?
    @IBOutlet weak var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = "Cancel"
        gridView?.gridDataSource = self
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        grid = engine.grid
        if let grid = grid {
            saveClosure?(grid)
            navigationController?.popViewController(animated: true)
        }
    }

}
