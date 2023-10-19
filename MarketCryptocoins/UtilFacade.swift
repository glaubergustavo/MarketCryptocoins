//
//  UtilFacade.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 10/10/23.
//

import UIKit

class UtilFacade {
    
    static func setGreenOrRedColor(value: String, changePercentage: Double) -> NSAttributedString {
        let color = (changePercentage.sign == .minus) ? UIColor.systemRed : UIColor.systemGreen
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)
        ]
        let attributedString = NSAttributedString(string: value, attributes: attributes)
        
        return attributedString
    }
    
    static func setGreenOrRedColorAndJoinText(value: String, changePercentage: Double) -> NSMutableAttributedString {
        let valueAttributedString = NSMutableAttributedString(string: value)
        let color = (changePercentage.sign == .minus) ? UIColor.systemRed : UIColor.systemGreen
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)
        ]
        let attributedString = NSAttributedString(string: changePercentage.toPercentage(), attributes: attributes)
        
        valueAttributedString.append(attributedString)
        
        return valueAttributedString
    }
}
