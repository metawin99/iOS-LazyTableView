//
//  ViewController.swift
//  iOS-LazyTableView-Swift
//
//  Created by Jared on 5/27/16.
//  Copyright © 2016 Jared Stefanowicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, L3SDKLazyTableViewDelegate
{
    struct ViewControllerConstants
    {
        static let lazyLoadPageSize = 15
    }
    
    var dataSource: [String]!
    
    @IBOutlet weak var lazyTableView: L3SDKLazyTableView!
    
    @IBOutlet weak var itemsIndicatorLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.dataSource = [String]()
        
        fetchNewItems()
        
        self.lazyTableView.delegate = self
        self.lazyTableView.dataSource = self
        self.lazyTableView.lazyLoad.enabled = true
        self.lazyTableView.lazyLoad.pageSize = ViewControllerConstants.lazyLoadPageSize
    }

    func fetchNewItems()
    {
        var counter = self.dataSource.count
        for _ in 0..<ViewControllerConstants.lazyLoadPageSize
        {
            dataSource.append("Item - \(counter+1)")
            counter += 1
        }
        
        self.itemsIndicatorLabel.text = "\(counter) items loaded."
    }
    
    // MARK: Lazyload Table View
    
    func tableView(tableView: UITableView, lazyLoadNextCursor cursor: Int) {
        fetchNewItems()
        lazyTableView.reloadData()
    }
    
    // MARK: Table View 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel!.text = self.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
}

