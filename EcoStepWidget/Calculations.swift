//
//  Calculations.swift
//  Eco Steps
//
//  Created by Mai Dang on 3/11/23.
//

import Foundation
import SwiftUI
import HealthKit

struct Calculations {    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
    
    
    
    
}
