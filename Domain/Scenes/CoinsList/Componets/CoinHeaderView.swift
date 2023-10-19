//
//  CoinHeaderView.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 10/09/23.
//

import UIKit

class CoinHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CoinHeaderView"
    
    @IBOutlet weak var priceChangePercentageLabel: UILabel!
    
    func setupPriceChangePercentage(from filter: Filter) {
        if filter.type == .priceChangePercentage {
            if let priceChangePercentageFilter = PriceChangePercentageFilterEnum(rawValue: filter.key) {
                priceChangePercentageLabel.text = priceChangePercentageFilter.title
            }
        }
    }
}
