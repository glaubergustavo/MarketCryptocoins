//
//  GenericDataProvider.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 08/09/23.
//

import Foundation

protocol GenericDataProviderDelegate {
    func sucess(model: Any)
    func errorData(_ provider: GenericDataProviderDelegate?, error: Error)
}

class DataProviderManager<T, S> {
    var delegate: T?
    var model: S?
}
