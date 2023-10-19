//
//  GradientColorPickerView.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 10/10/23.
//

import UIKit

class GradientColorPickerView: UIPickerView {
    
    override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            // Crie um gradiente linear
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = bounds
            gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.black.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            
            layer.insertSublayer(gradientLayer, at: 0)
        }
}
