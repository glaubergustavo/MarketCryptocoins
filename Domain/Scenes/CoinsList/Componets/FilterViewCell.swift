//
//  FilterViewCell.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 10/09/23.
//

import UIKit

class FilterViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterLabel: UILabel!
    
    static let identifier = "FilterViewCell"
    
    
    
    func setupCell(filter: Filter) {
        switch filter.type {
        case .coins:
            if let coinsFilter = CoinsFilterEnum(rawValue: filter.key) {
                filterLabel.text = coinsFilter.symbol
            }
        case .top:
            if let key = Int(filter.key), let topFilter = TopFilterEnum(rawValue: key) {
                filterLabel.text = topFilter.title
            }
        case .priceChangePercentage:
            if let priceChangePercentageFilter = PriceChangePercentageFilterEnum(rawValue: filter.key) {
                filterLabel.text = priceChangePercentageFilter.title
            }
        case .orderBy:
            if let orderByFilter = OrderByFilterEnum(rawValue: filter.key) {
                filterLabel.text = "Ordenado por \(orderByFilter.title) \(orderByFilter.order)"
            }
        }
    }
    
    func addColorToCell(with color: UIColor) {
        self.contentView.backgroundColor = color
    }

}
