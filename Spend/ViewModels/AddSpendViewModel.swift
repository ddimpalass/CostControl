//
//  AddSpendViewModel.swift
//  Spend
//
//  Created by Apple on 21.05.2021.
//

import Foundation

protocol AddSpendViewModelProtocol {
    var name: String { get }
    var cost: String { get }
    
    init(period: Period?, spend: Spend?)
    
    func spendAction()
}

class AddSpendViewModel: AddSpendViewModelProtocol, ObservableObject {
    
    @Published var name: String = ""
    @Published var cost: String = ""
    var spendIsValid: Bool {
        name.count > 0 && cost.count > 0
    }
    
    var period: Period? = nil
    var spend: Spend? = nil
    
    required init(period: Period?, spend: Spend?) {
        self.period = period
        self.spend = spend
        guard spend != nil else { return }
        self.name = spend!.name!
        self.cost = "\(spend!.cost)"
    }
    
    func spendAction() {
        if spend != nil {
            SpendStorageManager.shared.updateSpend(spend: spend!, name: name, cost: cost)
        } else if period != nil {
            SpendStorageManager.shared.addSpend(period: period!, name: name, cost: cost)
        }
    }
}
