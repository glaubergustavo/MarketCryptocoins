//
//  LoadingView.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 10/10/23.
//

import UIKit

class LoadingView: UIView {
    
    private var parentView: UIView?
    private var isBackground = true
    
    lazy var backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = .systemGray6
        return activityIndicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)


    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(parentView: UIView, isBackground: Bool, isLarger: Bool) {
        self.init(frame: .zero)
        self.parentView = parentView
        self.isBackground = isBackground
        
        self.indicatorView.style = isLarger ? .large : .medium
    }
    
    func commomInit() {
        setupView()
    }
}

extension LoadingView {
    
    private func setupView() {
        if isBackground {
            addSubviews(backgroundView, indicatorView)
            
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            
            if let parentView {
                backgroundView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
                backgroundView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
                backgroundView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
                backgroundView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
            } else {
                backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
                backgroundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
                backgroundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            }
            
            indicatorView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            indicatorView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        } else {
            addSubviews(indicatorView)
            
            indicatorView.translatesAutoresizingMaskIntoConstraints = false

            if let parentView {
                indicatorView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
                indicatorView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
            } else {
                indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

            }
        }
    }
}
