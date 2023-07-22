//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    func work(client: Client) {
        let number = client.turn
        
        print("\(number)번 고객 \(client.banking.rawValue) 업무 시작")
        Thread.sleep(forTimeInterval: client.banking.taskTime)
        print("\(number)번 고객 \(client.banking.rawValue) 업무 완료")
    }
}
