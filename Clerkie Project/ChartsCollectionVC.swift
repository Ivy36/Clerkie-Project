////
////  ChartsCollectionVC.swift
////  Clerkie Project
////
////  Created by Jing on 2017/11/12.
////  Copyright © 2017年 Jing. All rights reserved.
////
//
//import UIKit
//import Charts
//
//private let reuseIdentifier = "ChartCell"
//
////let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
////let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
//
//class ChartsCollectionVC: UICollectionViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Register cell classes
//        self.collectionView!.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//        // Do any additional setup after loading the view.
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChartCollectionViewCell
////        if indexPath.section == 0 {
////            var barChartView = BarChartView()
////            barChartView.noDataText = "No data available"
////            var dataEntries: [BarChartDataEntry] = []
////            
////            for i in 0..<months.count {
//////                let dataEntry = BarChartDataEntry(value: unitsSold[i], xIndex: i)
////                let dataEntry = BarChartDataEntry.init(x: Double(i), y: unitsSold[i])
////                dataEntries.append(dataEntry)
////            }
////            
////            let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
//////            let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
////            let chartData = BarChartData(dataSet: chartDataSet)
////            barChartView.data = chartData
////            cell.chartView.addSubview(barChartView)
////        }
//    
//        // Configure the cell
//    
//        return cell
//    }
//
//    
//
//}

