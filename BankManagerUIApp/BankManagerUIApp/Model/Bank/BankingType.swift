//
//  BankingType.swift
//  BankManagerUIApp
//
//  Created by Hyungmin Lee on 2023/07/22.
//

enum BankingType: String, CaseIterable {
    case deposit = "예금"
    case loan = "대출"
    
    var taskTime: Double {
        switch self {
        case .deposit:
            return 0.7
        case .loan:
            return 1.1
        }
    }
}
