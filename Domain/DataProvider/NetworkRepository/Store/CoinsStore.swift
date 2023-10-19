//
//  CoinsStore.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 08/09/23.
//

import Foundation

protocol CoinsStoreProtocol: GenericStoreProtocol {
    func fetchListCoins(by vcCurrency: String,
                        with cryptocurrency: [String]?,
                        orderBy order: String,
                        total perPage: Int,
                        page: Int,
                        percentagePrice: String,
                        completion: @escaping completion<[CoinModel]?>)
    func fetchHistorical(by id: String,
                        currency vcCurrency: String,
                        from: String,
                        to: String,
                        completion: @escaping completion<MarketChartModel?>)
    func fetchHistorical(by id: String,
                        currency vcCurrency: String,
                        of days: String,
                        completion: @escaping completion<[GraphicDataModel]?>)
    func fetchCoin(by id: String, completion: @escaping completion<CurrentDataModel?>)
}

class CoinsStore: GenericStoreRequest, CoinsStoreProtocol {
    func fetchListCoins(by vcCurrency: String,
                        with cryptocurrency: [String]?,
                        orderBy order: String,
                        total perPage: Int,
                        page: Int,
                        percentagePrice: String,
                        completion: @escaping completion<[CoinModel]?>) {
        do {
            guard let url = try CoinsRouter.coinsMarkets(currency: vcCurrency,
                                                         cryptocurrency: cryptocurrency,
                                                         order: order,
                                                         perPage: perPage,
                                                         page: page,
                                                         percentage: percentagePrice).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    func fetchHistorical(by id: String,
                         currency vcCurrency: String,
                         from: String,
                         to: String,
                         completion: @escaping completion<MarketChartModel?>) {
        do {
            guard let url = try CoinsRouter.coinsByIdMarketChart(id: id,
                                                                 currency: vcCurrency,
                                                                 from: from,
                                                                 to: to).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    func fetchHistorical(by id: String,
                         currency vcCurrency: String,
                         of days: String,
                         completion: @escaping completion<[GraphicDataModel]?>) {
        do {
            guard let url = try CoinsRouter.coinsByIdOhlc(id: id,
                                                          currency: vcCurrency,
                                                          days: days).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    func fetchCoin(by id: String,
                   completion: @escaping completion<CurrentDataModel?>) {
        do {
            guard let url = try CoinsRouter.coinsById(id: id).asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    
}
