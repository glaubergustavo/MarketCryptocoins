//
//  BaseViewController.swift
//  MarketCryptocoins
//
//  Created by madeinweb on 23/09/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Object lifecycle
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradient(colors: UIColor.systemBlue.cgColor, UIColor.black.cgColor, UIColor.darkGray.cgColor)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.backButtonTitle = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: Setup

    func setup() {
        preconditionFailure("This method must be overrriden")
    }
    
    func showError(for message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
            if self is CoinViewController {
                self.navigationController?.popViewController(animated: true)
            } else {
                exit(0)
            }
        }))
        alert.addAction(UIAlertAction(title: "Tentar Novamente", style: .default, handler: handler))
        
        present(alert, animated: true)
    }

}
