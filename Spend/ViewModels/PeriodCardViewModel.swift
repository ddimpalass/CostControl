//
//  PeriodCardViewModel.swift
//  Spend
//
//  Created by Apple on 18.05.2021.
//

import Foundation
import Combine

protocol PeriodCardViewModelProtocol {
    var name: String { get }
    var dayNow: String { get }
    var dayCount: String { get }
    var dayLimit: String { get }
    var periodLimit: String { get }
    
    init(period: Period)
}

class PeriodCardViewModel: PeriodCardViewModelProtocol, ObservableObject {
    
    @Published var name = ""
    @Published var dayNow = ""
    @Published var dayCount = ""
    @Published var dayLimit = ""
    @Published var periodLimit = ""
    
    private var period: Period? = nil {
        willSet {
            name = newValue?.name ?? "Название"
            dayNow = "День \(DateManager.shared.dayInPeriod(start: newValue?.startDate, end: Date()) + 1)"
            dayCount = "/\(DateManager.shared.dayInPeriod(start: newValue?.startDate, end: newValue?.endDate))"
            periodLimit = "\((newValue?.limit ?? 0)/(DateManager.shared.dayInPeriod(start: newValue?.startDate, end: newValue?.endDate)))"
        }
    }
    
    private var spends: [Spend] = [] {
        willSet {
            dayLimit = "\(Int32(periodLimit)! - DateManager.shared.costByDate(spends: newValue, date: Date()))"
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(period: Period) {
        let periodPublisher: AnyPublisher<[Period], Never> = PeriodStorageManager.shared.periods.eraseToAnyPublisher()
        periodPublisher
            .sink{ [unowned self] periods in
                self.period = periods.first{ $0 == period } ?? period
            }
            .store(in: &self.cancellable)
        let spendPublisher: AnyPublisher<[Spend], Never> = SpendStorageManager.shared.spends.eraseToAnyPublisher()
        spendPublisher
            .sink{ [unowned self] spends in
                self.spends = spends.filter{ $0.period == period }
            }
            .store(in: &self.cancellable)
    }
    
}

