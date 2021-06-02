//
//  PeriodHeaderViewModel.swift
//  Spend
//
//  Created by Apple on 24.05.2021.
//

import Foundation
import Combine

protocol PeriodHeaderViewModelProtocol {
    var status: String { get }
    var count: String { get }
    
    init(there: Status)
}

enum Status {
    case active
    case completed
}

class PeriodHeaderViewModel: PeriodHeaderViewModelProtocol, ObservableObject {
    @Published var status: String = ""
    @Published var count: String = ""
    
    private var there: Status
    
    private var activePeriods: [Period] = [] {
        willSet {
            guard there == .active else { return }
            if newValue.count > 0 {
                status = "Активные"
                count = "\(newValue.count)"
            } else {
                status = "Добавь период"
                count = ""
            }
        }
    }
    
    private var completedPeriods: [Period] = [] {
        willSet {
            guard there == .completed else { return }
            if  newValue.count > 0 {
                status = "Завершенные"
                count = "\(newValue.count)"
            } else {
                status = ""
                count = ""
            }
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(there: Status) {
        self.there = there
        let periodPublisher: AnyPublisher<[Period], Never> = PeriodStorageManager.shared.periods.eraseToAnyPublisher()
        periodPublisher
            .sink{ [unowned self] periods in
                self.activePeriods = periods
                    .sorted{ $0.startDate! > $1.startDate! }
                    .filter{ $0.endDate! > Date()}
                self.completedPeriods = periods
                    .sorted{ $0.endDate! > $1.endDate! }
                    .filter{ $0.endDate! < Date()}
            }
            .store(in: &self.cancellable)
    }
}
