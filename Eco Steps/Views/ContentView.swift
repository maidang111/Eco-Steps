//
//  ContentView.swift
//  Eco Steps
//
//  Created by Mai Dang on 3/10/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
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
    
    var body: some View {
        
        NavigationView {
        
        GraphView(steps: steps)
            
        .navigationTitle("Eco Step")
        }
       
        
            .onAppear {
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        if success {
                            healthStore.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    // update the UI
                                    updateUIFromStatistics(statisticsCollection)
                                }
                            }
                        }
                    }
                }
            }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Text("Eco Steps")
//        .fontWeight(.heavy)
//        .fontDesign(.serif)
//        .foregroundColor(Color("AccentColor"))
