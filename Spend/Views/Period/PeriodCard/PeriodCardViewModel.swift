//
//  PeriodCardViewModel.swift
//  Spend
//
//  Created by Apple on 18.05.2021.
//

import Foundation

protocol PeriodCardViewModelProtocol {
    var name: String { get }
    var dayNow: String { get }
    var dayCount: String { get }
//    var dayLimit: String { get }
    var periodLimit: String { get }
    
    init(period: Period)
}

class PeriodCardViewModel: PeriodCardViewModelProtocol, ObservableObject {
    
    var name: String {
        period.name ?? "Название"
    }
    
    var dayNow: String {
        "\(dayInPeriod(start: period.startDate ?? Date(), end: Date()) + 1)"
    }
    
    var dayCount: String {
        "/\(dayInPeriod(start: period.startDate!, end: period.endDate!))"
    }
    
//    var dayLimit: String {
//        "\(period.limit/(dayInPeriod(start: period.startDate!, end: period.endDate!)) - costByDate(spendDict: gropedByDate(spends: period.spendsArray)))"
//    }
    
    var periodLimit: String {
        "/\(period.limit/(dayInPeriod(start: period.startDate!, end: period.endDate!)))"
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
}
