//
//  PeriodMainScreenViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import Foundation

protocol PeriodMainScreenViewModelProtocol {
    var periodIsEnd: Bool { get }
    
    init(period: Period)
}

class PeriodMainScreenViewModel: PeriodMainScreenViewModelProtocol, ObservableObject {
    var periodIsEnd: Bool {
        DateManager.shared.periodIsEnd(end: period.endDate)
    }

    var period: Period
    
    required init(period: Period) {
        self.period = period
    }

}
