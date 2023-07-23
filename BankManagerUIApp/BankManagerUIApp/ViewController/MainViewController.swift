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
    
    private lazy var bank: Bank = {
        let bank = Bank(depositBankManagerCount: 2, loanBankManagerCount: 1)
        bank.delegate = self
        return bank
    }()
    
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
        let operationQueue = OperationQueue()
        
        bank.addClientQueue()
        operationQueue.addOperation { self.bank.startTask() }
    }
    
    func didTappedResetClientButton() {
        bank.resetTask()
    }
}

// MARK: - Bank Delegate
extension MainViewController: BankDelegate {
    func addWatingClient(_ turn: Int, _ bankingType: BankingType) {
        mainView.addWatingClient(turn, bankingType)
    }
    
    func moveClientToProcessing(_ turn: Int) {
        mainView.moveClientToProcessing(turn)
    }
    
    func finishProcessingClient(_ turn: Int) {
        mainView.finishProcessingClient(turn)
    }
}
