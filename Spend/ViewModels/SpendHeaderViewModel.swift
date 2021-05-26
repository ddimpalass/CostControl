//
//  SpendHeaderViewModel.swift
//  Spend
//
//  Created by Apple on 17.05.2021.
//

import Foundation
import Combine

protocol SpendHeaderViewModelProtocol {
    var dateString: String { get }
    var costSum: String { get }
    
    init(date: Date, spendsByDate: [Spend])
}

class SpendHeaderViewModel: SpendHeaderViewModelProtocol, ObservableObject {
    @Published var costSum: String = ""
    
    var spends: [Spend] = [] {
        willSet {
            costSum = "\(DateManager.shared.costByDate(spends: newValue, date: date))"
        }
    }
    
    var dateString: String {
        DateManager.shared.dateFormatterForDate.string(from: date)
    }
    
    var date: Date
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(date: Date, spendsByDate: [Spend]) {
        self.date = date
        let spendPublisher: AnyPublisher<[Spend], Never> = SpendStorageManager.shared.spends.eraseToAnyPublisher()
        spendPublisher
            .sink{ [unowned self] spends in
                self.spends = spends.filter{ $0.period == spendsByDate.first?.period }
            }
            .store(in: &self.cancellable)
    }
}
