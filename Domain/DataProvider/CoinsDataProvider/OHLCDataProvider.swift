//
//  OHLCDataProvider.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 03/10/23.
//

import Foundation

protocol OHLCDataProviderDelegate: GenericDataProviderDelegate { }

class OHLCDataProvider: DataProviderManager<OHLCDataProviderDelegate, [GraphicDataModel]> {
    
    private let coinStrore: CoinsStoreProtocol?
    
    init(coinStrore: CoinsStoreProtocol = CoinsStore()) {
        self.coinStrore = coinStrore
    }
    
    func fetchOhlc(by id: String, currency: String, of: String) {
        coinStrore?.fetchHistorical(by: id, currency: currency, of: of, completion: { result, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            
            if let result {
                self.delegate?.sucess(model: result)
            }
        })
    }
}
