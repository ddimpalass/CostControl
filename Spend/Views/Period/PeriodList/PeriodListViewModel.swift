//
//  PeriodListViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import Foundation
import Combine

protocol PeriodListViewModelProtocol {
    var periods: [Period] { get }
}

class PeriodListViewModel: PeriodListViewModelProtocol, ObservableObject{
    
    @Published var periods: [Period] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init(periodPublisher: AnyPublisher<[Period], Never> = PeriodStorageManager.shared.periods.eraseToAnyPublisher()) {
        periodPublisher
            .sink{ periods in
                self.periods = periods
            }
            .store(in: &cancellable)
    }
    
}
