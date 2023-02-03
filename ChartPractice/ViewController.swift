//
//  ViewController.swift
//  ChartPractice
//
//  Created by 10305 on 2023/2/2.
//

import Charts
import UIKit

class ViewController: UIViewController {
    var chartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChartView()
    }

    func setUpChartView() {
        chartView = LineChartView(frame: CGRect(x: 20, y: 80, width: 300, height: 500))
        view.addSubview(chartView)

        chartView.backgroundColor = .yellow
        chartView.noDataText = "暫無數據"

        // 折线图描述文字和样式
        chartView.chartDescription.text = "考试成绩"
        chartView.chartDescription.textColor = UIColor.red
        chartView.chartDescription.font = UIFont.systemFont(ofSize: 20)
        
        chartView.drawGridBackgroundEnabled = true  //绘制图形区域背景
        chartView.drawBordersEnabled = true  //绘制图形区域边框
        chartView.gridBackgroundColor = .lightGray //背景改成黄色
        chartView.borderColor = .blue  //边框为蓝色
        chartView.borderLineWidth = 3  //边框线条大小为3

        // 设置交互样式
        chartView.scaleYEnabled = true // 取消Y轴缩放
        chartView.doubleTapToZoomEnabled = true // 双击缩放
        chartView.dragEnabled = true // 启用拖动手势
        chartView.dragDecelerationEnabled = true // 拖拽后是否有惯性效果
        chartView.dragDecelerationFrictionCoef = 0.1 // 拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
        
        // 圖例樣式
        chartView.legend.textColor = UIColor.purple
        chartView.legend.formSize = 10
        chartView.legend.form = .circle

        // 生成8条随机数据
        var dataEntries1 = [ChartDataEntry]()
        for i in 0 ..< 8 {
            let y = Int.random(in: 70...100)
            let entry = ChartDataEntry(x: Double(i), y: Double(y))
            dataEntries1.append(entry)
        }
        // 这50条数据作为1根折线里的所有数据
        let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "李子明")
        chartDataSet1.colors = [.orange]
        chartDataSet1.circleColors = [.orange]
        chartDataSet1.circleRadius = 5 //外圆半径
        chartDataSet1.circleHoleRadius = 2 //内圆半径

        // 生成第二組數據
        var dataEntries2 = [ChartDataEntry]()
        for i in 0 ..< 8 {
            let y = Int.random(in: 70...100)
            let entry = ChartDataEntry(x: Double(i), y: Double(y))
            dataEntries2.append(entry)
        }
        // 这50条数据作为1根折线里的所有数据
        let chartDataSet2 = LineChartDataSet(entries: dataEntries2, label: "王大明")
        chartDataSet2.colors = [.purple]
        chartDataSet2.circleColors = [.purple]
        //chartDataSet.circleHoleColor = .red  //内圆颜色
        chartDataSet2.circleRadius = 5 //外圆半径
        chartDataSet2.circleHoleRadius = 2 //内圆半径


        // 目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])

        // 设置折现图数据
        chartView.data = chartData
    }
}
