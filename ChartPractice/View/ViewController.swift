//
//  ViewController.swift
//  ChartPractice
//
//  Created by 10305 on 2023/2/2.
//

import Charts
import UIKit

class ViewController: UIViewController {
    typealias RecordDataSource = UITableViewDiffableDataSource<RecordCategory, RecordItem>
    typealias RecordSnapshot = NSDiffableDataSourceSnapshot<RecordCategory, RecordItem>

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource: RecordDataSource!
    private let viewModel = RecordViewModel()
    static let reuseIdentifier = "recordReuseIdentifier"

    lazy var segmentedControl: UISegmentedControl = {
        var items = RecordDuration.allCases.map{ $0.rawValue }
        return UISegmentedControl(items: items)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegmentedControl()
        configureTableView()
        configureDataSource()
        configureSnapshot()
    }

    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.reuseIdentifier)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemIndigo

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureDataSource() {
        dataSource = RecordDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.reuseIdentifier, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.recordType.description
            cell.contentConfiguration = content
            return cell
        })
    }

    func configureSnapshot() {
        var snapshot = RecordSnapshot()
        snapshot.appendSections(RecordCategory.allCases)
        viewModel.items.forEach { item in
            switch item.recordType {
            case .barChart:
                snapshot.appendItems([item], toSection: .chart)
            case .focus, .rest:
                snapshot.appendItems([item], toSection: .summary)
            }
        }
        dataSource.apply(snapshot)
    }

    func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .systemIndigo
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)

        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}


//func setUpChartView() {
//    chartView = LineChartView(frame: CGRect(x: 20, y: 80, width: 300, height: 500))
//    view.addSubview(chartView)
//
//    chartView.backgroundColor = .yellow
//    chartView.noDataText = "????????????"
//
//    // ??????????????????????????????
//    chartView.chartDescription.text = "????????????"
//    chartView.chartDescription.textColor = UIColor.red
//    chartView.chartDescription.font = UIFont.systemFont(ofSize: 20)
//
//    chartView.drawGridBackgroundEnabled = true  //????????????????????????
//    chartView.drawBordersEnabled = true  //????????????????????????
//    chartView.gridBackgroundColor = .lightGray //??????????????????
//    chartView.borderColor = .blue  //???????????????
//    chartView.borderLineWidth = 3  //?????????????????????3
//
//    // ??????????????????
//    chartView.scaleYEnabled = true // ??????Y?????????
//    chartView.doubleTapToZoomEnabled = true // ????????????
//    chartView.dragEnabled = true // ??????????????????
//    chartView.dragDecelerationEnabled = true // ??????????????????????????????
//    chartView.dragDecelerationFrictionCoef = 0.1 // ?????????????????????????????????(0~1)????????????????????????
//
//    // ????????????
//    chartView.legend.textColor = UIColor.purple
//    chartView.legend.formSize = 10
//    chartView.legend.form = .circle
//
//    // ??????8???????????????
//    var dataEntries1 = [ChartDataEntry]()
//    for i in 0 ..< 8 {
//        let y = Int.random(in: 70...100)
//        let entry = ChartDataEntry(x: Double(i), y: Double(y))
//        dataEntries1.append(entry)
//    }
//    // ???50???????????????1???????????????????????????
//    let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "?????????")
//    chartDataSet1.colors = [.orange]
//    chartDataSet1.circleColors = [.orange]
//    chartDataSet1.circleRadius = 5 //????????????
//    chartDataSet1.circleHoleRadius = 2 //????????????
//
//    // ?????????????????????
//    var dataEntries2 = [ChartDataEntry]()
//    for i in 0 ..< 8 {
//        let y = Int.random(in: 70...100)
//        let entry = ChartDataEntry(x: Double(i), y: Double(y))
//        dataEntries2.append(entry)
//    }
//    // ???50???????????????1???????????????????????????
//    let chartDataSet2 = LineChartDataSet(entries: dataEntries2, label: "?????????")
//    chartDataSet2.colors = [.purple]
//    chartDataSet2.circleColors = [.purple]
//    //chartDataSet.circleHoleColor = .red  //????????????
//    chartDataSet2.circleRadius = 5 //????????????
//    chartDataSet2.circleHoleRadius = 2 //????????????
//
//
//    // ????????????????????????1?????????
//    let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])
//
//    // ?????????????????????
//    chartView.data = chartData
//}
