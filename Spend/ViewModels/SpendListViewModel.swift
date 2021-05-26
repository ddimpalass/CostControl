//
//  SpendListViewModel.swift
//  Spend
//
//  Created by Apple on 14.05.2021.
//

import Foundation
import Combine

protocol SpendListViewModelProtocol {
    init(period: Period)
}

class SpendListViewModel: SpendListViewModelProtocol, ObservableObject {
    @Published var spendsGroupByDate: Array<(key: Date, value: Array<Spend>)> = []
    
    @Published var spends: [Spend] = [] {
        willSet {
            spendsGroupByDate = DateManager.shared.gropedByDate(spends: newValue)
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(period: Period) {
        let spendPublisher: AnyPublisher<[Spend], Never> = SpendStorageManager.shared.spends.eraseToAnyPublisher()
        spendPublisher
            .sink{ [unowned self] spends in
                self.spends = spends.filter{ $0.period == period }
            }
            .store(in: &self.cancellable)
    }
}

