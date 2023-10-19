//
//  DateValueFormatter.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 07/10/23.
//

import Foundation
import Charts

enum DateValueFormatterEnum {
    case hour
    case day
    case month
    case year
}

class DateValueFormatter: AxisValueFormatter {
    
    weak var chart: BarLineChartViewBase?
    var type: DateValueFormatterEnum
    
    init(chart: BarLineChartViewBase, type: DateValueFormatterEnum = .month) {
        self.chart = chart
        self.type = type
    }
    
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        let date = Date(milliseconds: Int64(value))
        
        switch type {
        case .hour:
            return date.formatter(to: "HH:mm")
        case .day:
            let order = Calendar.current.compare(Date(), to: date, toGranularity: .day)
            if order == .orderedSame {
                return date.formatter(to: "HH:mm")
            } else {
                return date.formatter(to: "dd, MMM")
            }
        case .month:
            let order = Calendar.current.compare(Date(), to: date, toGranularity: .month)
            if order == .orderedSame {
                return date.formatter(to: "dd, MMM")
            } else {
                return date.formatter(to: "MMM, YYYY")
            }
        case .year:
            let order = Calendar.current.compare(Date(), to: date, toGranularity: .year)
            if order == .orderedSame {
                return date.formatter(to: "MMM, YYYY")
            } else {
                return date.formatter(to: "YYYY")
            }
        }
    }

}
