//
//  PeriodLineViewModel.swift
//  Spend
//
//  Created by Apple on 18.05.2021.
//

import Foundation

protocol PeriodLineViewModelProtocol {
    var name: String { get }
    var balance: String { get }
    var limit: String { get }
    var selectedPeriod: Period? { get }
    func selectPeriodButtonPressed()
    
    init (period: Period)
}

class PeriodLineViewModel: PeriodLineViewModelProtocol, ObservableObject {
    
    var name: String {
        period.name ?? "Название"
    }
    
    var balance: String {
        "\(period.limit - period.spendsArray.map({$0.cost}).reduce(0, +))"
    }
    
    var limit: String {
        "/\(period.limit)"
    }
    
    @Published var selectedPeriod: Period? = nil

    private var period: Period
    
    required init(period: Period) {
        self.period = period
    }
    
    func selectPeriodButtonPressed() {
        selectedPeriod = period
    }
    
}
