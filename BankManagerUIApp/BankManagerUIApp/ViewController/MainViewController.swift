//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    private lazy var mainView: MainView = {
       let mainView = MainView()
        mainView.delegate = self
        return mainView
    }()
    private let bank = Bank(depositBankManagerCount: 2, loanBankManagerCount: 1)
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - MainView Delegate
extension MainViewController: MainViewDelegate {
    func didTappedAddClientButton() {
        
    }
    
    func didTappedResetClientButton() {
        
    }
}
