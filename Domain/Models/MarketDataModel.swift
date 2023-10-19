//
//  MarketDataModel.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 08/09/23.
//

import Foundation

struct MarketDataModel: Codable {
    let currentPrice: [String: Double]
    let marketCap: [String: Double]
    let fullyDilutedValuation: [String: Double]
    let totalVolume: [String: Double]
    let high24H: [String: Double]
    let low24H: [String: Double]
    let priceChangePercentage1HInCurrency: [String: Double]
    let priceChangePercentage24HInCurrency: [String: Double]
    let priceChangePercentage7DInCurrency: [String: Double]
    let priceChangePercentage14DInCurrency: [String: Double]
    let priceChangePercentage30DInCurrency: [String: Double]
    let priceChangePercentage60DInCurrency: [String: Double]
    let priceChangePercentage1YInCurrency: [String: Double]
    let ath: [String: Double]
    let athChangePercentage: [String: Double]
    let athDate: [String: Date]
    let atl: [String: Double]
    let atlChangePercentage: [String: Double]
    let atlDate: [String: Date]
    let totalSupply: Double?
    let maxSupply: Double?
    let circulatingSupply: Double
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
    }
}
