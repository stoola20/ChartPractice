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
