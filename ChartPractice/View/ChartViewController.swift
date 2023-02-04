//
//  ChartViewController.swift
//  ChartPractice
//
//  Created by 10305 on 2023/2/4.
//

import Charts
import UIKit

class ChartViewController: UIViewController {
    var chartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpChartView(duration: .monthly)
        setUpChartData(duration: .monthly)
    }

    func setUpChartView(duration: RecordDuration) {
        chartView = BarChartView()
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.midY),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // 使用者互動設定
        chartView.drawBarShadowEnabled = false
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.doubleTapToZoomEnabled = false

        // X軸刻度
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: duration.xValues)
        chartView.xAxis.labelCount = duration.xValues.count
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.granularity = duration.xGranularity
        chartView.xAxis.axisMinimum = -1
        chartView.xAxis.axisMaximum = Double(duration.xValues.count)
        chartView.xAxis.drawGridLinesEnabled = false

        // y軸刻度
        chartView.rightAxis.enabled = false

        var yValues: [String] = []
        for index in 0...30 {
            yValues.append("\(index)")
        }
        chartView.leftAxis.valueFormatter = IndexAxisValueFormatter(values: yValues)
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 30
        chartView.leftAxis.granularity = 5
        chartView.leftAxis.drawAxisLineEnabled = false

        // 動畫
        chartView.animate(xAxisDuration: 0.2, yAxisDuration: 0.7, easingOptionX: .easeInOutQuart, easingOptionY: .easeOutBack)

        //
        chartView.noDataText = "無資料"
    }

    func setUpChartData(duration: RecordDuration) {
        var dataEntries = [BarChartDataEntry()]
        for index in 0 ..< duration.xValues.count {
            let y = Int.random(in: 0...30)
            let entry = BarChartDataEntry(x: Double(index), y: Double(y))
            dataEntries.append(entry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        chartDataSet.colors = [.systemIndigo]
        chartDataSet.drawValuesEnabled = false

        let chartData = BarChartData(dataSets: [chartDataSet])
        chartView.data = chartData
    }
}
