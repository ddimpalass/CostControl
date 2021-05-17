//
//  SpendListViewModel.swift
//  Spend
//
//  Created by Apple on 14.05.2021.
//

import Foundation

protocol SpendListViewModelProtocol {
    var spendsDict: Array<(key: String, value: Array<Spend>)> { get }
    init(period: Period)
}

class SpendListViewModel: SpendListViewModelProtocol, ObservableObject {
    var spendsDict: Array<(key: String, value: Array<Spend>)> {
        gropedByDate(spends: period.spendsArray).sorted(by: {$0.key > $1.key})
    }
    
    private let period: Period
    
    required init(period: Period) {
        self.period = period
    }
    
    private func gropedByDate(spends: [Spend]) -> [String: [Spend]] {
        let sortedSpends = spends.sorted(by: {$0.date! > $1.date!})
        
        let groupedByDate = Dictionary(grouping: sortedSpends) { (spend: Spend) -> String in
            dateFormatterForDate.string(from: spend.date ?? Date())
        }
        return groupedByDate
    }
    
    private let dateFormatterForDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, E"
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        return formatter
    }()
}

