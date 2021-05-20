//
//  SpendHeaderViewModel.swift
//  Spend
//
//  Created by Apple on 17.05.2021.
//

import Foundation

protocol SpendHeaderViewModelProtocol {
    var date: String { get }
    var costSum: String { get }
    
    init(date: String, spends: [Spend])
}

class SpendHeaderViewModel: SpendHeaderViewModelProtocol, ObservableObject {
    var date: String 
    
    var costSum: String {
        "\(spends.map({$0.cost}).reduce(0, +))"
    }
    
    private let spends: [Spend]
    
    required init(date: String, spends: [Spend]) {
        self.date = date
        self.spends = spends
    }
}
