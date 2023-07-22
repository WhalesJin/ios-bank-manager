//
//  Bank.swift
//  BankManagerUIApp
//
//  Created by Hyungmin Lee on 2023/07/22.
//

import Foundation

final class Bank {
    private let depositBankManagerCount: Int
    private let loanBankManagerCount: Int
    private var clientQueue = Queue<Client>()
    private let bankManger = BankManager()
    
    private var depositOperationQueue = OperationQueue()
    private var loanOperationQueue = OperationQueue()
    
    init(depositBankManagerCount: Int, loanBankManagerCount: Int) {
        self.depositBankManagerCount = depositBankManagerCount
        self.loanBankManagerCount = loanBankManagerCount
        
        depositOperationQueue.maxConcurrentOperationCount = depositBankManagerCount
        loanOperationQueue.maxConcurrentOperationCount = loanBankManagerCount
    }
    
    func startTask() {
        let startTime = Date()
        var operaion: BlockOperation
        var operationQueue: OperationQueue

        while !clientQueue.isEmpty {
            guard let client = clientQueue.dequeue() else { break }
            
            operaion = BlockOperation { self.bankManger.work(client: client) }
            operationQueue = client.banking == .deposit ? depositOperationQueue : loanOperationQueue
            operationQueue.addOperation(operaion)
        }
        
        depositOperationQueue.waitUntilAllOperationsAreFinished()
        loanOperationQueue.waitUntilAllOperationsAreFinished()
    }
    
    func resetTask() {
        clientQueue.clear()
        depositOperationQueue.cancelAllOperations()
        loanOperationQueue.cancelAllOperations()
    }
    
    func addClientQueue() {
        var client: Client
        var bankingType: BankingType
        
        for turn in 1...10 {
            bankingType = BankingType.allCases.randomElement() ?? .deposit
            client = Client(turn, bankingType)
            clientQueue.enqueue(client)
        }
    }
}

// MARK: - Private
extension Bank {
    private func printTaskResult(_ clientCount: Int, _ startTime: Date) {
        let totalWorkTime = Date().timeIntervalSince(startTime)
        let formattedWorkTime = String(format: "%.2f", totalWorkTime)
        
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(clientCount)명이며, 총 업무시간은 \(formattedWorkTime)초입니다.")
    }
}
