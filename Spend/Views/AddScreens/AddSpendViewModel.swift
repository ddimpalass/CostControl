//
//  AddSpendViewModel.swift
//  Spend
//
//  Created by Apple on 21.05.2021.
//

import Foundation

protocol AddSpendViewModelProtocol {
    func addSpend(period: Period, name: String, cost: String)
    func updateSpend(spend: Spend, name: String, cost: String)
    
    init(period: Period, spend: Spend)
}

class AddSpendViewModel: AddSpendViewModelProtocol {
    
    func addSpend(period: Period, name: String, cost: String) {
        SpendStorageManager.shared.addSpend(period: period, name: name, cost: cost)
    }
    
    func updateSpend(spend: Spend, name: String, cost: String) {
        SpendStorageManager.shared.updateSpend(spend: spend, name: name, cost: cost)
    }
    
    let period: Period?
    let spend: Spend?
    
    required init(period: Period, spend: Spend) {
        self.period = period
        self.spend = spend
    }

}
