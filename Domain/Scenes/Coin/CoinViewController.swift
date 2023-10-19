//
//  CoinViewController.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 24/09/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Charts

protocol CoinDisplayLogic: AnyObject {
    func displayCoin(viewModel: Coin.FetchCurrentData.ViewModel)
    func displayMarketChart(viewModel:Coin.FetchMarketChart.ViewModel)
    func displayOhlc(viewModel: Coin.FetchOhlc.ViewModel)
    func displayError(error: String)
}

class CoinViewController: BaseViewController {
    
    @IBOutlet weak var coinValuesView: UIView! {
        didSet {
            coinValuesView.isHidden = true
        }
    }
    
    @IBOutlet weak var changePercentageLabel: UILabel!
    @IBOutlet weak var coinCurrentPriceBaseCurrencyLabel: UILabel!
    @IBOutlet weak var marketDataCoinCurrentPriceLabel: UILabel!
    @IBOutlet weak var marketDataCoinIconImageView: UIImageView!
    @IBOutlet weak var marketDataCoinSymbolLabel: UILabel!
    @IBOutlet weak var marketDataComparationActionView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didComparationCoin))
            marketDataComparationActionView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketDataComparationCurrencyPriceLabel: UILabel!
    @IBOutlet weak var marketDataComparationSymbolLabel: UILabel!
    
    @IBOutlet weak var coinGraphicView: UIView! {
        didSet {
            coinGraphicView.isHidden = true
        }
    }
    
    @IBOutlet weak var marketChartView: LineChartView!
    
    @IBOutlet weak var marketChartOneHourView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeMarketChartOneHour))
            marketChartOneHourView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketChartOneHourLabel: UILabel!
    
    @IBOutlet weak var marketChartOneDayView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeMarketChartOneDay))
            marketChartOneDayView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketChartOneDayLabel: UILabel!
    
    @IBOutlet weak var marketChartOneWeekView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeMarketChartOneWeek))
            marketChartOneWeekView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketChartOneWeekLabel: UILabel!
    
    @IBOutlet weak var marketChartOneMonthView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeMarketChartOneMonth))
            marketChartOneMonthView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketChartOneMonthLabel: UILabel!
    
    @IBOutlet weak var marketChartThreeMonthsView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeMarketChartThreeMonths))
            marketChartThreeMonthsView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketChartThreeMonthsLabel: UILabel!
    
    @IBOutlet weak var marketChartOneYearView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeMarketChartOneYear))
            marketChartOneYearView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketChartOneYearLabel: UILabel!
    
    @IBOutlet weak var marketChartMaximumView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeMarketChartMaximum))
            marketChartMaximumView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var marketChartMaximumLabel: UILabel!
    
    @IBOutlet weak var priceChangePercentageOneDayLabel: UILabel!
    @IBOutlet weak var priceChangePercentageOneWeekLabel: UILabel!
    @IBOutlet weak var priceChangePercentageTwoWeeksLabel: UILabel!
    @IBOutlet weak var priceChangePercentageOneMonthLabel: UILabel!
    @IBOutlet weak var priceChangePercentageTwoMonthsLabel: UILabel!
    @IBOutlet weak var priceChangePercentageOneYearLabel: UILabel!
    
    @IBOutlet weak var coinResumeView: UIView! {
        didSet {
            coinResumeView.isHidden = true
        }
    }
    
    @IBOutlet weak var marketClassificationRankLabel: UILabel!
    @IBOutlet weak var marketCaptalizationLabel: UILabel!
    @IBOutlet weak var fullyDilutedValuationLabel: UILabel!
    @IBOutlet weak var volumeBusinessLabel: UILabel!
    @IBOutlet weak var twentyFourHourHigthLabel: UILabel!
    @IBOutlet weak var twentyFourHourLowLabel: UILabel!
    @IBOutlet weak var supplyAvailableLabel: UILabel!
    @IBOutlet weak var totalSupplyLabel: UILabel!
    @IBOutlet weak var maximumSupplyLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    @IBOutlet weak var maximumPercentageLabel: UILabel!
    @IBOutlet weak var maximumDateLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var minimumPercentageLabel: UILabel!
    @IBOutlet weak var minimumDateLabel: UILabel!
    
    private lazy var coinsFilterView: FiltersView = {
       let filterView = FiltersView()
        filterView.isHidden = true
        filterView.delegate = self
        filterView.filterOptions = filtersUtils.coinsFilter
        return filterView
    }()
    
    var interactor: CoinBusinessLogic?
    var router: (NSObjectProtocol & CoinRoutingLogic & CoinDataPassing)?
    
    private var viewModel: Coin.FetchCurrentData.ViewModel?
    private let filtersUtils = FiltersUtils.shared
    private var timeSelection = DateTimeEnum.hour
    private var typeDateValueFormatter = DateValueFormatterEnum.hour
    private var graphTimeViews: [UIView] = []
    private var graphTimeLabels: [UILabel] = []
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        loadUI()
    }
    
    // MARK: Setup
    
    override func setup() {
        let viewController = self
        let interactor = CoinInteractor()
        let presenter = CoinPresenter()
        let router = CoinRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func loadUI() {
        doFetchCurrentData()
        doFetchMarketChartHourly()
    }
    
    private func configUI() {
        view.addSubview(coinsFilterView)
        
        graphTimeViews = [marketChartOneHourView, marketChartOneDayView, marketChartOneWeekView, marketChartOneMonthView, marketChartThreeMonthsView, marketChartOneYearView, marketChartMaximumView]
        graphTimeLabels = [marketChartOneHourLabel, marketChartOneDayLabel, marketChartOneWeekLabel, marketChartOneMonthLabel, marketChartThreeMonthsLabel, marketChartOneYearLabel, marketChartMaximumLabel]
        
        marketChartOneHourLabel.textColor = .yellow
        marketChartOneHourView.backgroundColor = .black
        
        setupGraphic()
        setupCoinFilter()
    }
    
    func setupCoinFilter() {
        let filter = filtersUtils.getSelectedCoinsFilter()
        switch filter {
        case .brl:
            coinsFilterView.filterPickerView.selectRow(0, inComponent: 0, animated: true)
        case .usd:
            coinsFilterView.filterPickerView.selectRow(1, inComponent: 0, animated: true)
        case .eur:
            coinsFilterView.filterPickerView.selectRow(2, inComponent: 0, animated: true)
        }
    }
    
    func setupGraphic() {
        marketChartView.delegate = self
        
        marketChartView.rightAxis.enabled = false
        
        marketChartView.leftAxis.labelFont = .systemFont(ofSize: 9)
        marketChartView.leftAxis.setLabelCount(6, force: true)
        marketChartView.leftAxis.labelTextColor = .white
        marketChartView.leftAxis.axisLineColor = .white
        marketChartView.leftAxis.labelPosition = .outsideChart
        marketChartView.xAxis.labelPosition = .bottom
        marketChartView.xAxis.labelTextColor = .white
    }
    
    func doFetchCurrentData() {
        MarketCoinsLoading.shared.start(from: view)
        
        let baseCoin = filtersUtils.getSelectedCoinsFilter()
        
        let request = Coin.FetchCurrentData.Request(baseCoin: baseCoin)
        interactor?.doFetchCurrentData(request: request)
    }
    
    func doFetchMarketChartHourly() {
        marketChartView.isHidden = true
        MarketCoinsLoading.shared.start(from: coinGraphicView, isBackground: false, isLarge: false)
        
        let baseCoin = filtersUtils.getSelectedCoinsFilter()
        let from = Date().addingTimeInterval(-60 * 60)
        let to = Date()
        
        let request = Coin.FetchMarketChart.Request(baseCoin: baseCoin, from: from, to: to)
        interactor?.doFetchMarketChart(request: request)
    }
    
    func doFetchOhlc() {
        marketChartView.isHidden = true
        MarketCoinsLoading.shared.start(from: coinGraphicView, isBackground: false, isLarge: false)

        let baseCoin = filtersUtils.getSelectedCoinsFilter()
        
        let request = Coin.FetchOhlc.Request(baseCoin: baseCoin, day: timeSelection.rawValue)
        interactor?.doFetchOhlc(request: request)
    }
    
    @objc func didComparationCoin() {
        coinsFilterView.cellRow = 0
        coinsFilterView.viewAnimation(with: 0.5)
    }
    
    @objc func didChangeMarketChartOneHour() {
        timeSelection = .hour
        typeDateValueFormatter = DateValueFormatterEnum.hour
        doFetchMarketChartHourly()
        
        marketChartOneHourLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartOneHourView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
    }
    
    @objc func didChangeMarketChartOneDay() {
        timeSelection = .day
        typeDateValueFormatter = DateValueFormatterEnum.day
        doFetchOhlc()
        
        marketChartOneDayLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartOneDayView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
    }
    
    @objc func didChangeMarketChartOneWeek() {
        timeSelection = .week
        typeDateValueFormatter = DateValueFormatterEnum.month
        doFetchOhlc()
        
        marketChartOneWeekLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartOneWeekView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
    }
    
    @objc func didChangeMarketChartOneMonth() {
        timeSelection = .month
        typeDateValueFormatter = DateValueFormatterEnum.month
        doFetchOhlc()
        
        marketChartOneMonthLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartOneMonthView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
    }
    
    @objc func didChangeMarketChartThreeMonths() {
        timeSelection = .threeMonths
        typeDateValueFormatter = DateValueFormatterEnum.month
        doFetchOhlc()
        
        marketChartThreeMonthsLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartThreeMonthsView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
    }
    
    @objc func didChangeMarketChartOneYear() {
        timeSelection = .year
        typeDateValueFormatter = DateValueFormatterEnum.month
        doFetchOhlc()
        
        marketChartOneYearLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartOneYearView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
    }
    
    @objc func didChangeMarketChartMaximum() {
        timeSelection = .max
        typeDateValueFormatter = DateValueFormatterEnum.year
        doFetchOhlc()
        
        marketChartMaximumLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartMaximumView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
    }
}

extension CoinViewController: CoinDisplayLogic {
    
    func displayCoin(viewModel: Coin.FetchCurrentData.ViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            
            self.title = viewModel.coinName

            self.coinValuesView.isHidden = false
            self.coinCurrentPriceBaseCurrencyLabel.text = viewModel.currentPrice
            self.changePercentageLabel.attributedText = viewModel.priceChangePercentage
            self.marketDataCoinCurrentPriceLabel.text = viewModel.coinPrice
            self.marketDataCoinIconImageView.loadImage(from: viewModel.coinImage)
            self.marketDataCoinSymbolLabel.text = viewModel.coinSymbol
            self.marketDataComparationCurrencyPriceLabel.text = viewModel.currentPriceComparationToCoin
            self.marketDataComparationSymbolLabel.text = viewModel.comparationToCoinSymbol
            
            self.coinGraphicView.isHidden = false
            self.priceChangePercentageOneDayLabel.attributedText = viewModel.priceChangePercentageOneDay
            self.priceChangePercentageOneWeekLabel.attributedText = viewModel.priceChangePercentageOneWeek
            self.priceChangePercentageTwoWeeksLabel.attributedText = viewModel.priceChangePercentageTwoWeeks
            self.priceChangePercentageOneMonthLabel.attributedText = viewModel.priceChangePercentageOneMonth
            self.priceChangePercentageTwoMonthsLabel.attributedText = viewModel.priceChangePercentageTwoMonths
            self.priceChangePercentageOneYearLabel.attributedText = viewModel.priceChangePercentageOneYear
            
            self.coinResumeView.isHidden = false
            self.marketClassificationRankLabel.text = viewModel.marketCapRank
            self.marketCaptalizationLabel.text = viewModel.marketCap
            self.fullyDilutedValuationLabel.text = viewModel.fullyDilutedValuation
            self.volumeBusinessLabel.text = viewModel.totalVolume
            self.twentyFourHourLowLabel.text = viewModel.low24H
            self.twentyFourHourHigthLabel.text = viewModel.higth24H
            self.supplyAvailableLabel.text = viewModel.supplyAvailable
            self.totalSupplyLabel.text = viewModel.totalSupply
            self.maximumSupplyLabel.text = viewModel.maxSupply
            self.maximumValueLabel.text = viewModel.maximumValue
            self.maximumPercentageLabel.attributedText = viewModel.maximumValuePercentage
            self.maximumDateLabel.text = viewModel.maximumValueDate
            self.minimumValueLabel.text = viewModel.minimumValue
            self.minimumPercentageLabel.attributedText = viewModel.minimumValuePercentage
            self.minimumDateLabel.text = viewModel.minimumValueDate

            MarketCoinsLoading.shared.stop(from: self.view)
        }
    }
    
    func displayMarketChart(viewModel: Coin.FetchMarketChart.ViewModel) {
        DispatchQueue.main.async {
            self.setData(from: viewModel.dataEntries,
                         minPrice: viewModel.minimumPrice,
                         maxPrice: viewModel.maximumPrice)
            
            self.marketChartView.isHidden = false
            MarketCoinsLoading.shared.stop(from: self.coinGraphicView)

        }
    }
    
    func displayOhlc(viewModel: Coin.FetchOhlc.ViewModel) {
        DispatchQueue.main.async {
            self.marketChartView.isHidden = false
            MarketCoinsLoading.shared.stop(from: self.coinGraphicView)
            
            self.setData(from: viewModel.dataEntries,
                         minPrice: viewModel.minimumPrice,
                         maxPrice: viewModel.maximumPrice)
        }
    }
    
    func displayError(error: String) {
        DispatchQueue.main.async {
            MarketCoinsLoading.shared.stop(from: self.view)
            MarketCoinsLoading.shared.stop(from: self.coinGraphicView)

            self.showError(for: error) { action in
                self.doFetchCurrentData()
                self.doFetchMarketChartHourly()
            }
        }
    }
    
    private func setData(from entry: [ChartDataEntry], minPrice: Double, maxPrice: Double) {
        let baseCoin = filtersUtils.getSelectedCoinsFilter()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: baseCoin.locale)
        
        marketChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: numberFormatter)
        marketChartView.leftAxis.axisMinimum = minPrice
        marketChartView.leftAxis.axisMaximum = maxPrice
        
        marketChartView.xAxis.valueFormatter = DateValueFormatter(chart: marketChartView, type: typeDateValueFormatter)
        
        let dataSet = LineChartDataSet(entries: entry, label: "")
        setupDataSet(dataSet)
    }
    
    private func setupDataSet(_ dataSet: LineChartDataSet) {
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.setColor(.systemBlue, alpha: 0.8)
        dataSet.gradientPositions = [100, 0, 100]
        
        let gradientColors = [
            ChartColorTemplates.colorFromString("#0080bf").cgColor,
            ChartColorTemplates.colorFromString("#00acdf").cgColor
        ]
        
        if let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil) {
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        }
        dataSet.fillAlpha = 0.8
        dataSet.drawFilledEnabled = true
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: dataSet)
        data.setDrawValues(false)
        marketChartView.data = data
    }
}

extension CoinViewController: ToolbarFiltersViewDelegate {
    
    func filtersView(_ filtersView: FiltersView, didSelect filter: Filter, forCellRow row: Int) {
        filtersUtils.setSelectedFilter(to: filter, of: row)
        
        doFetchCurrentData()
        doFetchMarketChartHourly()
        
        marketChartOneHourLabel.addColorToLabelAndDecolorizetoLabels(labels: graphTimeLabels, color: .yellow)
        marketChartOneHourView.addColorToViewAndDecolorizetoViews(views: graphTimeViews, color: .black)
        
        cancelFilter(for: filtersView)
    }
    
    func cancelFilter(for filtersView: FiltersView) {
        setupCoinFilter()
        filtersView.viewAnimation(with: 0.5)
        filtersView.isHidden = true
    }
}

extension CoinViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let baseCoin = filtersUtils.getSelectedCoinsFilter()
        let value = entry.y.toCurrency(from: baseCoin)
        
        coinCurrentPriceBaseCurrencyLabel.text = value
        changePercentageLabel.text = ""
    }
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        coinCurrentPriceBaseCurrencyLabel.text = viewModel?.currentPrice
        changePercentageLabel.attributedText = viewModel?.priceChangePercentage
    }
}
