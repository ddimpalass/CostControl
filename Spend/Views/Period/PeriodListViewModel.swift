//
//  PeriodListViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import CoreData

protocol PeriodListViewModelProtocol {
    var periods: [Period] { get set }
}

class PeriodListViewModel: PeriodListViewModelProtocol {
    var periods: [Period] = []
    
    
}
