//
//  DoubleLineChartTableViewCell.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import Charts

/* Data source and default settings for double line chart
 */
class DoubleLineChartTableViewCell: UITableViewCell {
    
    let unitsSold1 = [15.0, 7.0, 5.0, 4.0, 10.0, 15.0, 8.0, 13.0, 10.0, 6.0, 4.0, 2.0]

    @IBOutlet weak var dbLineChartView: UIView!
    
    func setChart() {
        // Retrieve data
        var dataEntries: [ChartDataEntry] = []
        var dataEntries1: [ChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry.init(x: Double(i), y: unitsSold[i])
            dataEntries.append(dataEntry)
            let dataEntry1 = ChartDataEntry.init(x: Double(i), y: unitsSold1[i])
            dataEntries1.append(dataEntry1)
        }
        
        //Configure settings for both lines separately
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Units Sold 1")
        let chartDataSet1 = LineChartDataSet.init(values: dataEntries1, label: "Units Sold 2")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        chartDataSet1.colors = [UIColor(red: 144/255, green: 197/255, blue: 73/255, alpha: 1)]
        chartDataSet.circleRadius = 2.0
        chartDataSet1.circleRadius = 2.0
        chartDataSet.circleColors = [UIColor.gray]
        chartDataSet1.circleColors = [UIColor.lightGray]
        let chartData = LineChartData.init(dataSets: [chartDataSet, chartDataSet1])
        
        //Settings for the chart view
        let newGraph = LineChartView()
        newGraph.frame = CGRect(x: 0, y: 0, width: dbLineChartView.bounds.width, height: dbLineChartView.bounds.height)
        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        newGraph.xAxis.labelPosition = .bottom
        newGraph.chartDescription?.text = ""
        newGraph.rightAxis.enabled = false
        newGraph.xAxis.drawGridLinesEnabled = false
        newGraph.leftAxis.drawGridLinesEnabled = false
        newGraph.data = chartData
        
        print("newGraph = \(newGraph)")
        dbLineChartView.addSubview(newGraph)
    }

}
