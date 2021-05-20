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
    var dayLimit: String { get }
    var periodLimit: String { get }
    
    init(period: Period)
}

class PeriodCardViewModel: PeriodCardViewModelProtocol, ObservableObject {
    
    var name: String {
        period.name ?? "Название"
    }
    
    var dayNow: String {
        "\(DateManager.shared.dayInPeriod(start: period.startDate ?? Date(), end: Date()) + 1)"
    }
    
    var dayCount: String {
        "/\(DateManager.shared.dayInPeriod(start: period.startDate!, end: period.endDate!))"
    }
    
    var dayLimit: String {
        "\(period.limit/(DateManager.shared.dayInPeriod(start: period.startDate!, end: period.endDate!)) - DateManager.shared.costByDate(spendDict: DateManager.shared.gropedByDate(spends: period.spendsArray)))"
    }
    
    var periodLimit: String {
        "/\(period.limit/(DateManager.shared.dayInPeriod(start: period.startDate!, end: period.endDate!)))"
    }
    
    private let period: Period
    
    required init(period: Period) {
        self.period = period
    }
}
