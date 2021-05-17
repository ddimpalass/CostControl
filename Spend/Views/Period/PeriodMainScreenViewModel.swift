//
//  PeriodMainScreenViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import Foundation

protocol PeriodMainScreenViewModelProtocol {
    var name: String { get }
    var dayNow: String { get }
    var dayCount: String { get }
    var dayLimit: String { get }
    var periodLimit: String { get }
    var periodForNextView: Period { get }
    
    init(period: Period)
}

class PeriodMainScreenViewModel: PeriodMainScreenViewModelProtocol {
    var name: String {
        period.name ?? ""
    }
    
    var dayNow: String {
        "\(dayInPeriod(start: period.startDate!, end: Date()) + 1)"
    }
    
    var dayCount: String {
        "\(dayInPeriod(start: period.startDate!, end: period.endDate!))"
    }
    
    var dayLimit: String {
        "\(period.limit/(dayInPeriod(start: period.startDate!, end: period.endDate!)) - costByDate(spendDict: gropedByDate(spends: period.spendsArray)))"
    }
    
    var periodLimit: String {
        "\(period.limit/(dayInPeriod(start: period.startDate!, end: period.endDate!)))"
    }
    
    var periodForNextView: Period {
        period
    }
    
    private let period: Period
    
    required init(period: Period) {
        self.period = period
    }
    
    private func dayInPeriod(start: Date, end: Date) -> Int32 {
        let calendar = Calendar.current

        let from = calendar.startOfDay(for: start)
        let to = calendar.startOfDay(for: end)

        let components = calendar.dateComponents([.day], from: from, to: to)
        
        return Int32(components.day ?? 1)
    }
    
    private func costByDate(spendDict: [String: [Spend]]) -> Int32 {
        guard let spendArrayInDate = spendDict[dateFormatterForDate.string(from: Date())] else { return 0 }
        let costInDate = spendArrayInDate.map({$0.cost}).reduce(0, +)
        return costInDate
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
