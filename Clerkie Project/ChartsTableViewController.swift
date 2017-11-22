//
//  ChartsTableViewController.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import Charts

let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

class ChartsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Set different charts for each cell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "barChartCell", for: indexPath) as! BarChartTableViewCell
            cell.setChart()
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pieChartCell", for: indexPath) as! PieChartTableViewCell
            cell.setChart()
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "lineChartCell", for: indexPath) as! LineChartTableViewCell
            cell.setChart()
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "doubleLineChartCell", for: indexPath) as! DoubleLineChartTableViewCell
            cell.setChart()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "horizontalBarChartCell", for: indexPath) as! HorizontalBarChartTableViewCell
            cell.setChart()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //set the height for each row
        return CGFloat(300)
    }

}

