//
//  BarChartTableViewCell.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import Charts

/* Data source and default settings for bar chart
 */
class BarChartTableViewCell: UITableViewCell {
    @IBOutlet weak var barChartView: UIView!
    
    func setChart() {
        //Retrieve data
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry.init(x: Double(i), y: Double(unitsSold[i]))
            dataEntries.append(dataEntry)
        }

        //Configure settings for the bar
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1), UIColor(red: 144/255, green: 197/255, blue: 73/255, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        
        //Settings for the chart view
        let newGraph = BarChartView()
        newGraph.frame = CGRect(x: 0, y: 0, width: barChartView.bounds.width, height: barChartView.bounds.height)
        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        newGraph.xAxis.labelPosition = .bottom
        newGraph.chartDescription?.text = ""
        newGraph.rightAxis.enabled = false
        newGraph.xAxis.drawGridLinesEnabled = false
        newGraph.leftAxis.drawGridLinesEnabled = false
        newGraph.data = chartData
     
        print("newGraph = \(newGraph)")
        barChartView.addSubview(newGraph)
    }
}

