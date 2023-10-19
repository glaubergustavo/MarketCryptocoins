//
//  CurrentDataDataProvider.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 03/10/23.
//

import Foundation

protocol CurrentDataDataProviderDelegate: GenericDataProviderDelegate { }

class CurrentDataDataProvider: DataProviderManager<CurrentDataDataProviderDelegate, CurrentDataModel> {
    
    private let coinStrore: CoinsStoreProtocol?
    
    init(coinStrore: CoinsStoreProtocol = CoinsStore()) {
        self.coinStrore = coinStrore
    }
    
    func fetchCoin(by id: String) {
        coinStrore?.fetchCoin(by: id, completion: { result, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            
            if let result {
                self.delegate?.sucess(model: result)
            }
        })
    }
}
