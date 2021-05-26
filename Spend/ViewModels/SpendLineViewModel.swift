//
//  SpendLineViewModel.swift
//  Spend
//
//  Created by Apple on 17.05.2021.
//

import Foundation
import Combine

protocol SpendLineViewModelProtocol {
    var name: String { get }
    var time: String { get }
    var cost: String { get }
    var selectedSpend: Spend? { get }
    func selectSpendButtonPressed()
    
    init(for: Spend)
}

class SpendLineViewModel: SpendLineViewModelProtocol, ObservableObject {

    @Published var name: String = ""
    @Published var time: String = ""
    @Published var cost: String = ""
    
    @Published var selectedSpend: Spend? = nil
    
    var spend: Spend = Spend() {
        willSet {
            name = newValue.name ?? "Название"
            time = DateManager.shared.dateFormatterForTime.string(from: newValue.date ?? Date())
            cost = "\(newValue.cost)"
        }
    }

    private var cancellable = Set<AnyCancellable>()
    
    required init(for spendIn: Spend) {
        let spendPublisher: AnyPublisher<[Spend], Never> = SpendStorageManager.shared.spends.eraseToAnyPublisher()
        spendPublisher
            .sink{ [unowned self] spends in
                self.spend = spends.first{ $0 == spendIn } ?? Spend()
            }
            .store(in: &self.cancellable)
    }

    func selectSpendButtonPressed() {
        selectedSpend = spend
    }
}
