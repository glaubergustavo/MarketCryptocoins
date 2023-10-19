//
//  MarketChartDataProvider.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 03/10/23.
//

import Foundation

protocol MarketChartDataProviderDelegate: GenericDataProviderDelegate { }

class MarketChartDataProvider: DataProviderManager<MarketChartDataProviderDelegate, MarketDataModel> {
    
    private let coinStrore: CoinsStoreProtocol?
    
    init(coinStrore: CoinsStoreProtocol = CoinsStore()) {
        self.coinStrore = coinStrore
    }
    
    func fetchMarketChartRange(by id: String, currency: String, from: String, to: String) {
        coinStrore?.fetchHistorical(by: id, currency: currency, from: from, to: to, completion: { result, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            
            if let result {
                self.delegate?.sucess(model: result)
            }
        })
    }
}
