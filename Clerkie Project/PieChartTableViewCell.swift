//
//  PieChartTableViewCell.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import Charts

/* Data source and default settings for pie chart
 */
class PieChartTableViewCell: UITableViewCell {

    @IBOutlet weak var pieChartView: UIView!
    
    func setChart() {
        print("set chart")
        // Retrieve data
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = PieChartDataEntry.init(value: unitsSold[i], label: months[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        //Configure settings
        chartDataSet.colors = [UIColor.init(red: 144/255, green: 197/255, blue: 73/255, alpha: 1), UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)];
        chartDataSet.xValuePosition = .insideSlice;
        chartDataSet.yValuePosition = .outsideSlice;
        chartDataSet.sliceSpace = 1
        chartDataSet.selectionShift = 6.66
        chartDataSet.valueColors = [UIColor.gray]
        chartDataSet.valueLineColor = UIColor.brown
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let newGraph = PieChartView()
        newGraph.usePercentValuesEnabled = true
        newGraph.chartDescription?.text = "Units Sold"
        newGraph.chartDescription?.font = UIFont.systemFont(ofSize: 10.0)
        newGraph.legend.enabled = false
        newGraph.frame = CGRect(x: 0, y: 0, width: pieChartView.bounds.width, height: pieChartView.bounds.height)
        newGraph.entryLabelFont = UIFont.systemFont(ofSize: 6.0)
    
        newGraph.data = chartData
        
        print("newGraph = \(newGraph)")
        pieChartView.addSubview(newGraph)
    }

}
