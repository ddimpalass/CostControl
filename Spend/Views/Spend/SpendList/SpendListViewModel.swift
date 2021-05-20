//
//  SpendListViewModel.swift
//  Spend
//
//  Created by Apple on 14.05.2021.
//

import Foundation

protocol SpendListViewModelProtocol {
    init(period: Period)
}

class SpendListViewModel: SpendListViewModelProtocol, ObservableObject {
    var spendsDict: Array<(key: String, value: Array<Spend>)> {
        DateManager.shared.gropedByDate(spends: period.spendsArray).sorted(by: {$0.key > $1.key})
    }
    
    private let period: Period
    
    required init(period: Period) {
        self.period = period
    }
}

