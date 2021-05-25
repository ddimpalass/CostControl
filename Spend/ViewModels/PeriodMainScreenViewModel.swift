//
//  PeriodMainScreenViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import Foundation

protocol PeriodMainScreenViewModelProtocol {
    init(period: Period)
}

class PeriodMainScreenViewModel: PeriodMainScreenViewModelProtocol, ObservableObject {

    var period: Period
    
    required init(period: Period) {
        self.period = period
    }

}
