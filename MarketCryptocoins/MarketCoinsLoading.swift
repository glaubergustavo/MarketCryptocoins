//
//  MarketCoinsLoading.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 10/10/23.
//

import UIKit

class MarketCoinsLoading {
    
    public static let shared = MarketCoinsLoading()
    
    private init() {}
    
    func start(from view: UIView, isBackground: Bool = true, isLarge: Bool = true) {
        let loading = LoadingView(parentView: view, isBackground: isBackground, isLarger: isLarge)
        loading.indicatorView.startAnimating()
        view.addSubview(loading)
        loading.commomInit()
    }
    
    func stop(from view: UIView) {
        for view in view.subviews {
            if let view = view as? LoadingView {
                view.indicatorView.stopAnimating()
                view.removeFromSuperview()
            }
        }
    }
}
