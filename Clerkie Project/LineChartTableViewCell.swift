//
//  LineChartTableViewCell.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import Charts

class LineChartTableViewCell: UITableViewCell {

    @IBOutlet weak var lineChartView: UIView!
    
    func setChart() {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry.init(x: Double(i), y: unitsSold[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        chartDataSet.circleRadius = 2.0
        chartDataSet.circleColors = [UIColor.gray]
        let chartData = LineChartData(dataSet: chartDataSet)
        let newGraph = LineChartView()
        newGraph.frame = CGRect(x: 0, y: 0, width: lineChartView.bounds.width, height: lineChartView.bounds.height)
        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        newGraph.xAxis.labelPosition = .bottom
        newGraph.chartDescription?.text = ""
        newGraph.rightAxis.enabled = false
        newGraph.data = chartData
        
        print("newGraph = \(newGraph)")
        lineChartView.addSubview(newGraph)
    }

}
