//
//  Client.swift
//  BankManagerUIApp
//
//  Created by Hyungmin Lee on 2023/07/22.
//

struct Client {
    let turn: Int
    let bankingType: BankingType
    
    init(_ turn: Int, _ bankingType: BankingType) {
        self.turn = turn
        self.bankingType = bankingType
    }
}
