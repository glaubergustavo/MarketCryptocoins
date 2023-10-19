//
//  MarketChartModel.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 08/09/23.
//

import Foundation

typealias GraphicDataModel = [Double]

struct MarketChartModel: Codable {
    let prices: [GraphicDataModel]
}
