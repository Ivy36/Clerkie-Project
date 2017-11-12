//
//  PieChartTableViewCell.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/12.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import Charts

class PieChartTableViewCell: UITableViewCell {

    @IBOutlet weak var pieChartView: UIView!
    
    func setChart() {
        print("set chart")
        //        barChartView.noDataText = "No data available"
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<months.count {
            //                let dataEntry = BarChartDataEntry(value: unitsSold[i], xIndex: i)
            
            let dataEntry = PieChartDataEntry.init(value: unitsSold[i], label: months[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        
        chartDataSet.colors = [UIColor.init(red: 144/255, green: 197/255, blue: 73/255, alpha: 1), UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)];
        
        chartDataSet.xValuePosition = .insideSlice;
        chartDataSet.yValuePosition = .outsideSlice;
        chartDataSet.sliceSpace = 1
        chartDataSet.selectionShift = 6.66
        chartDataSet.valueColors = [UIColor.gray]
        chartDataSet.valueLineColor = UIColor.brown
//        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = PieChartData(dataSet: chartDataSet)
        //print("barChartView = \(String(describing: barChartV))")
        //        barChartView.barData = chartData
        let newGraph = PieChartView()
        newGraph.usePercentValuesEnabled = true
//        newGraph.descriptionText = ""
        newGraph.chartDescription?.text = "Units Sold"
        newGraph.chartDescription?.font = UIFont.systemFont(ofSize: 10.0)
        //newGraph.legend.formSize = 0.0
        newGraph.legend.enabled = false
//        newGraph.backgroundColor = UIColor.init(red: 230/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0)
        
        newGraph.frame = CGRect(x: 0, y: 0, width: pieChartView.bounds.width, height: pieChartView.bounds.height)
        newGraph.entryLabelFont = UIFont.systemFont(ofSize: 6.0)
    
//        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
//        newGraph.xAxis.labelPosition = .bottom
//        newGraph.descriptionText = ""
//        newGraph.rightAxis.enabled = false
        //        newGraph.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        newGraph.data = chartData
        
        //        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        print("newGraph = \(newGraph)")
        pieChartView.addSubview(newGraph)
    }

}
