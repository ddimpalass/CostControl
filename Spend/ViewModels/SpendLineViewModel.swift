//
//  SpendLineViewModel.swift
//  Spend
//
//  Created by Apple on 17.05.2021.
//

import Foundation

protocol SpendLineViewModelProtocol {
    var name: String { get }
    var time: String { get }
    var cost: String { get }
    var selectedSpend: Spend? { get }
    func selectSpendButtonPressed()
    
    init(spend: Spend)
}

class SpendLineViewModel: SpendLineViewModelProtocol, ObservableObject {

    var name: String {
        spend.name ?? "Название"
    }
    
    var time: String {
        DateManager.shared.dateFormatterForTime.string(from: spend.date ?? Date())
    }
    
    var cost: String {
        "\(spend.cost)"
    }
    
    @Published var selectedSpend: Spend? = nil

    var spend: Spend
    
    required init(spend: Spend) {
        self.spend = spend
    }
    
    func selectSpendButtonPressed() {
        selectedSpend = spend
    }
 
}
