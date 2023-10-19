//
//  ListCoinsDataProvider.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 08/09/23.
//

import Foundation

protocol ListCoinsDataProviderDelegate: GenericDataProviderDelegate {}

class ListCoinsDataProvider: DataProviderManager<ListCoinsDataProviderDelegate, [CoinModel]> {
    
    private let coinsStore: CoinsStoreProtocol?
    
    init(coinsStore: CoinsStoreProtocol = CoinsStore()) {
        self.coinsStore = coinsStore
    }
    
    func fetchListCoins(by vcCurrency: String,
                        with cryptocurrency: [String]?,
                        orderBy order: String,
                        total perPage: Int,
                        page: Int,
                        percentagePrice: String) {
        
        coinsStore?.fetchListCoins(by: vcCurrency,
                                   with: cryptocurrency,
                                   orderBy: order,
                                   total: perPage,
                                   page: page,
                                   percentagePrice: percentagePrice,
                                   completion: { result, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            if let result {
                self.delegate?.sucess(model: result)
            }
        })
    }
}
