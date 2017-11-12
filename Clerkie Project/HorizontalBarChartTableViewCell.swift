//
//  HorizontalBarChartTableViewCell.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import Charts

class HorizontalBarChartTableViewCell: UITableViewCell {

    @IBOutlet weak var hrztBarChartView: UIView!
    func setChart() {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry.init(x: Double(i), y: Double(unitsSold[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1), UIColor(red: 144/255, green: 197/255, blue: 73/255, alpha: 1)]
        chartDataSet.drawValuesEnabled = true
        chartDataSet.valueTextColor = UIColor.black
        chartDataSet.drawIconsEnabled = true
        let chartData = BarChartData(dataSet: chartDataSet)
        let newGraph = HorizontalBarChartView()
        newGraph.frame = CGRect(x: 0, y: 0, width: hrztBarChartView.bounds.width, height: hrztBarChartView.bounds.height)
        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        newGraph.xAxis.labelPosition = .bottom
        newGraph.chartDescription?.text = ""
        newGraph.leftAxis.enabled = false
        newGraph.data = chartData
        
        
        print("newGraph = \(newGraph)")
        hrztBarChartView.addSubview(newGraph)
    }
}
