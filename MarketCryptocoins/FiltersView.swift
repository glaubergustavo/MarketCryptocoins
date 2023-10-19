//
//  FiltersView.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 10/09/23.
//

import UIKit

protocol ToolbarFiltersViewDelegate: AnyObject {
    func filtersView(_ filtersView: FiltersView, didSelect filter: Filter, forCellRow row: Int)
    func cancelFilter(for filtersView: FiltersView)
}

class FiltersView: UIView {
    
    private var selectedOptions: Filter?
    
    public weak var delegate: ToolbarFiltersViewDelegate?
    public var cellRow: Int = -1
    public var filterOptions: [Filter] = [] {
        didSet {
            selectedOptions = filterOptions.first
        }
    }
    
    lazy var filterToolbar: UIToolbar = {
       let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.tintColor = .white
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(self.cancelTapped))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    lazy var filterPickerView: UIPickerView = {
        let pickerView = GradientColorPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .clear
        pickerView.isUserInteractionEnabled = true
        
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
    }
    
    @objc private func doneTapped() {
        if let selectedOptions {
            delegate?.filtersView(self, didSelect: selectedOptions, forCellRow: cellRow)
        } else {
            cancelTapped()
        }
    }
    
    @objc private func cancelTapped() {
        delegate?.cancelFilter(for: self)
    }
}

extension FiltersView {
    
    private func setupView() {
        addSubviews(filterToolbar ,filterPickerView)
        
        filterToolbar.translatesAutoresizingMaskIntoConstraints = false
        filterToolbar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        filterToolbar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        filterToolbar.bottomAnchor.constraint(equalTo: filterPickerView.topAnchor).isActive = true
        
        filterPickerView.translatesAutoresizingMaskIntoConstraints = false
        filterPickerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        filterPickerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        filterPickerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension FiltersView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOptions =   filterOptions[row]
    }
}
extension FiltersView: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        let filter = filterOptions[row]
        
        switch filter.type {
        case .coins:
            if let coinsFilter = CoinsFilterEnum(rawValue: filter.key) {
                label.text = "\(coinsFilter.symbol) - \(coinsFilter.name)"
            }
        case .top:
            if let key = Int(filter.key), let topFilter = TopFilterEnum(rawValue: key) {
                label.text = topFilter.title
            }
        case .priceChangePercentage:
            if let priceChangePercentageFilter = PriceChangePercentageFilterEnum(rawValue: filter.key) {
                label.text = priceChangePercentageFilter.title
            }
        case .orderBy:
            if let orderByFilter = OrderByFilterEnum(rawValue: filter.key) {
                label.text = "Ordenado por \(orderByFilter.title) \(orderByFilter.order)"
            }
        }
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let filter = filterOptions[row]
        
        switch filter.type {
        case .coins:
            if let coinsFilter = CoinsFilterEnum(rawValue: filter.key) {
                return "\(coinsFilter.symbol) - \(coinsFilter.name)"
            }
        case .top:
            if let key = Int(filter.key), let topFilter = TopFilterEnum(rawValue: key) {
                return topFilter.title
            }
        case .priceChangePercentage:
            if let priceChangePercentageFilter = PriceChangePercentageFilterEnum(rawValue: filter.key) {
                return priceChangePercentageFilter.title
            }
        case .orderBy:
            if let orderByFilter = OrderByFilterEnum(rawValue: filter.key) {
                return "Ordenado por \(orderByFilter.title) \(orderByFilter.order)"
            }
        }
        
        return ""
    }
    
}
