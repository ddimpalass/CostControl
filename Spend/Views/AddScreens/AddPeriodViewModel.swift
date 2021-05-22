//
//  AddPeriodViewModel.swift
//  Spend
//
//  Created by Apple on 21.05.2021.
//

import Foundation

protocol AddPeriodViewModelProtocol {
    func addPeriod()
    func updatePeriod()
}

class AddPeriodViewModel {
    func addPeriod(name: String, limit: String, numberOfDays: String) {
        PeriodStorageManager.shared.addPeriod(name: name, limit: limit, numberOfDays: numberOfDays)
    }
    
    func updatePeriod(period: Period, name: String, limit: String, numberOfDays: String) {
        PeriodStorageManager.shared.updatePeriod(period: period, name: name, limit: limit, numberOfDays: numberOfDays)
    }
}
