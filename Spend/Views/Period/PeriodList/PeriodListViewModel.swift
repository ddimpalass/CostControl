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
    
    @Published var periods: [Period] = [] {
        willSet {
            
        }
    }
    
    private var cancellable: AnyCancellable?
    
    init(periodPublisher: AnyPublisher<[Period], Never> = StorageManager.shared.periods.eraseToAnyPublisher()) {
        cancellable = periodPublisher.sink(receiveValue: { periods in
            self.periods = periods
        })
    }
    
}
