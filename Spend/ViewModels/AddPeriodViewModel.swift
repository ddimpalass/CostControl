//
//  AddPeriodViewModel.swift
//  Spend
//
//  Created by Apple on 21.05.2021.
//

import Foundation

protocol AddPeriodViewModelProtocol {
    var name: String { get }
    var limit: String { get }
    var numberOfDays: String { get }
    
    init(period: Period?)
    
    func periodAction()
}

class AddPeriodViewModel: AddPeriodViewModelProtocol, ObservableObject {
    @Published var name: String = ""
    @Published var limit: String = ""
    @Published var numberOfDays: String = ""
    var periodIsValid: Bool {
        name.count > 0 && limit.count > 0 && numberOfDays.count > 0 && Int(limit) != 0 && Int(numberOfDays) != 0
    }
    
    var period: Period? = nil
    
    required init(period: Period?) {
        self.period = period
        guard period != nil else { return }
        name = period!.name!
        limit = "\(period!.limit)"
        numberOfDays = "\(DateManager.shared.dayInPeriod(start: period!.startDate!, end: period!.endDate!))"
    }
    
    func periodAction() {
        if period != nil {
            PeriodStorageManager.shared.updatePeriod(period: period!, name: name, limit: limit, numberOfDays: numberOfDays)
        } else {
            PeriodStorageManager.shared.addPeriod(name: name, limit: limit, numberOfDays: numberOfDays)
        }
    }
    
    
    
    
    func addPeriod(name: String, limit: String, numberOfDays: String) {
        PeriodStorageManager.shared.addPeriod(name: name, limit: limit, numberOfDays: numberOfDays)
    }
    
    func updatePeriod(period: Period, name: String, limit: String, numberOfDays: String) {
        PeriodStorageManager.shared.updatePeriod(period: period, name: name, limit: limit, numberOfDays: numberOfDays)
    }
}
