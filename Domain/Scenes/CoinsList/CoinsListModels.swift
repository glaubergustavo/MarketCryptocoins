//
//  CoinsListModels.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 09/09/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CoinsList {
  // MARK: Use cases
  
  enum FetchGlobalValues {
    struct Request {
        let baseCoin: CoinsFilterEnum
    }
    struct Response {
        let baseCoin: CoinsFilterEnum
        let totalMarketCap: [String: Double]
        let totalVolume: [String: Double]
        let changePercentage: Double
    }
    struct ViewModel {
        struct GlobalValue {
            let title: String
            let value: NSMutableAttributedString
        }
        let globalValues: [GlobalValue]
    }
  }
    
    enum FetchListCoins {
      struct Request {
          let baseCoin: CoinsFilterEnum
          let orderBy: OrderByFilterEnum
          let top: TopFilterEnum
          let pricePercentage: PriceChangePercentageFilterEnum
      }
      struct Response {
          let baseCoin: CoinsFilterEnum
          let id: String
          let symbol: String
          let name: String
          let image: String
          let currentPrice: Double
          let marketCap: Double
          let marketCapRank: Int?
          let priceChangePercentage: Double
      }
      struct ViewModel {
          struct Coin {
              let id: String
              let name: String
              let rank: String
              let iconUrl: String
              let symbol: String
              let price: String
              let priceChangePercentage: NSAttributedString
              let marketCap: String
          }
          let coins: [Coin]
      }
    }
}