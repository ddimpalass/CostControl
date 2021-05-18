//
//  PeriodMainScreenViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import Foundation

protocol PeriodMainScreenViewModelProtocol {
    var spendsDict: Array <(key: String, value: Array<Spend>)> { get }
//    var dayLimit: String { get }

    init(period: Period)
}

class PeriodMainScreenViewModel: PeriodMainScreenViewModelProtocol {

    
    var spendsDict: Array<(key: String, value: Array<Spend>)> {
        gropedByDate(spends: period.spendsArray).sorted(by: {$0.key > $1.key})
    }
    
//    var dayLimit: String {
//        
//    }
    
    let period: Period
    
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
    
    private func costByDate(spendDict: [String: [Spend]]) -> Int32 {
        guard let spendArrayInDate = spendDict[dateFormatterForDate.string(from: Date())] else { return 0 }
        let costInDate = spendArrayInDate.map({$0.cost}).reduce(0, +)
        return costInDate
    }

    private let dateFormatterForDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, E"
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        return formatter
    }()

}
