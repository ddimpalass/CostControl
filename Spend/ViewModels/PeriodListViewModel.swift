//
//  PeriodListViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import Foundation
import Combine

protocol PeriodListViewModelProtocol {
    var activePeriods: [Period] { get }
    var completedPeriods: [Period] { get }
}

class PeriodListViewModel: PeriodListViewModelProtocol, ObservableObject{
    
    @Published var activePeriods: [Period] = []
    @Published var completedPeriods: [Period] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init(periodPublisher: AnyPublisher<[Period], Never> = PeriodStorageManager.shared.periods.eraseToAnyPublisher()) {
        periodPublisher
            .sink{ periods in
                self.activePeriods = periods
                    .sorted{ $0.startDate! > $1.startDate! }
                    .filter{ $0.endDate! > Date()}
                self.completedPeriods = periods
                    .sorted{ $0.endDate! > $1.endDate! }
                    .filter{ $0.endDate! < Date()}
            }
            .store(in: &cancellable)
    }
}
