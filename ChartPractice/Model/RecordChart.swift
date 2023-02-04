//
//  RecordChart.swift
//  ChartPractice
//
//  Created by 10305 on 2023/2/3.
//

import Foundation

struct RecordItem: Hashable {
    let recordType: RecordType
}

enum RecordDuration: String, CaseIterable {
    case daily = "日"
    case weekly = "週"
    case monthly = "月"

    var xValues: [String] {
        var xValues: [String] = []
        switch self {
        case .daily:
            (0...23).forEach { hour in
                if hour < 10 {
                    xValues.append("0\(hour):00")
                } else {
                    xValues.append("\(hour):00")
                }
            }
        case .weekly:
            xValues = ["一", "二", "三", "四", "五", "六", "日"]
        case .monthly:
            (1...28).forEach { day in
                xValues.append("2/\(day)")
            }
        }
        return xValues
    }

    var xGranularity: Double {
        switch self {
        case .daily: return 3 // 間隔每 3 小時顯示座標
        case .weekly: return 1 // 間隔每 1 日顯示座標
        case .monthly: return 5 // 間隔每 5 日顯示座標
        }
    }
}

enum RecordType: CaseIterable {
    case barChart
    case focus
    case rest

    var description: String? {
        switch self {
        case .barChart: return nil
        case .focus: return "專注"
        case .rest: return "休息"
        }
    }
}

enum RecordCategory: CaseIterable {
    case chart
    case summary

    var description: String {
        switch self {
        case .chart: return "圖表"
        case .summary: return "概覽"
        }
    }
}
