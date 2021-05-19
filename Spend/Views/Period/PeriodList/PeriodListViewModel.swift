//
//  PeriodListViewModel.swift
//  Spend
//
//  Created by Apple on 15.05.2021.
//

import Foundation
import SwiftUI

protocol PeriodListViewModelProtocol {
    var periods: [Period] { get }
}

class PeriodListViewModel: PeriodListViewModelProtocol, ObservableObject{
    
    @Published var periods: [Period] = []
    
}
