//
//  CoinsListInteractor.swift
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

protocol CoinsListBusinessLogic {
    func doFetchGlobalValues(request: CoinsList.FetchGlobalValues.Request)
    func doFetchListCoins(request: CoinsList.FetchListCoins.Request)
}

protocol CoinsListDataStore {
  var coins: [CoinModel]? { get set }
}

class CoinsListInteractor: CoinsListBusinessLogic, CoinsListDataStore {
    var presenter: CoinsListPresentationLogic?
    var globalValuesWorker: GlobalValuesWorker?
    var coinListWorker: CoinsListWorker?
    var coins: [CoinModel]?

    
    init(presenter: CoinsListPresentationLogic = CoinsListPresenter(), globalValuesWorker: GlobalValuesWorker = GlobalValuesWorker(), coinListWorker: CoinsListWorker = CoinsListWorker()) {
        self.presenter = presenter
        self.globalValuesWorker = globalValuesWorker
        self.coinListWorker = coinListWorker
    }
    
    func doFetchGlobalValues(request: CoinsList.FetchGlobalValues.Request) {
        globalValuesWorker?.doFetchGlobalValues(completion: { result in
            switch result {
            case .success(let globalModel):
                self.createGlobalValuesResponse(baseCoin: request.baseCoin, global: globalModel)
            case .failure:
                self.presenter?.presentErrorForGlobalvalues(baseCoin: request.baseCoin)
            }
        })
    }
    
    func doFetchListCoins(request: CoinsList.FetchListCoins.Request) {
        let baseCoin = request.baseCoin.rawValue
        let orderBy = request.orderBy.rawValue
        let top = request.top.rawValue
        let percentagePrice = request.pricePercentage.rawValue
        
        coinListWorker?.doFetchListCoins(baseCoin: baseCoin,
                                         orderBy: orderBy,
                                         top: top,
                                         percentagePrice: percentagePrice,
                                         completion: { result in
            switch result {
            case .success(let listCoinModel):
                self.coins = listCoinModel ?? []
                self.createListCoinResponse(request: request, listCoins: listCoinModel)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        })
    }
    
    private func createGlobalValuesResponse(baseCoin: CoinsFilterEnum, global: GlobalModel?) {
        if let global {
            let totalMarketCap = global.data.totalMarketCap.filter { $0.key == baseCoin.rawValue }
            let totalVolume = global.data.totalVolume.filter { $0.key == baseCoin.rawValue }
            let changePercentage = global.data.marketCapChangePercentage24HUsd
            let response = CoinsList.FetchGlobalValues.Response(baseCoin: baseCoin,
                                                                totalMarketCap: totalMarketCap,
                                                                totalVolume: totalVolume,
                                                                changePercentage: changePercentage)
            
            presenter?.presentGlobalValues(response: response)
        } else {
            presenter?.presentErrorForGlobalvalues(baseCoin: baseCoin)
        }
    }
    
    private func createListCoinResponse(request: CoinsList.FetchListCoins.Request, listCoins: [CoinModel]?) {
        if let listCoins {
            func priceChangePercentage(pricePercentage: PriceChangePercentageFilterEnum, coin: CoinModel) -> Double {
                
                switch pricePercentage {
                    case .lastHour:
                        return coin.priceChangePercentage1H ?? 0.0
                    case .oneDay:
                        return coin.priceChangePercentage24H ?? 0.0
                    case .oneWeek:
                        return coin.priceChangePercentage7D ?? 0.0
                    case .oneMonth:
                        return coin.priceChangePercentage30D ?? 0.0
                }
            }
            
            let response = listCoins.map { coin in
                return CoinsList.FetchListCoins.Response(baseCoin: request.baseCoin,
                                                         id: coin.id,
                                                         symbol: coin.symbol,
                                                         name: coin.name,
                                                         image: coin.image,
                                                         currentPrice: coin.currentPrice ?? 0.0,
                                                         marketCap: coin.marketCap ?? 0.0,
                                                         marketCapRank: coin.marketCapRank,
                                                         priceChangePercentage: priceChangePercentage(pricePercentage: request.pricePercentage, coin: coin))
            }
            presenter?.presentListCoins(response: response)
        } else {
            presenter?.presentError(error: .undefinedError)
        }
    }
    
}
