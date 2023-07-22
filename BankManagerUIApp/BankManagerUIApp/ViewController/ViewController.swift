//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    let bank = Bank(depositBankManagerCount: 2, loanBankManagerCount: 1)
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTappedStartButton), for: .touchUpInside)
        button.setTitle("start", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTappedResetButton), for: .touchUpInside)
        button.setTitle("reset", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view.addSubview(startButton)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    @objc func didTappedStartButton() {
        DispatchQueue.global().async {
            self.bank.startTask()
        }
    }
    
    @objc func didTappedResetButton() {
        bank.resetTask()
    }
}

