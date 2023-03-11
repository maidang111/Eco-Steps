//
//  GraphView.swift
//  Eco Steps
//
//  Created by Mai Dang on 3/11/23.
//

import SwiftUI

struct GraphView: View {
    
    @State var showingDetail = false

    static let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
        
    }()
    
    let steps: [Step]
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                
                ForEach(steps, id: \.id) { step in
                    
                    let yValue = Swift.min(step.count/20, 300)
                    
                    VStack {
                        Text("\(step.count)")
                            .font(.caption)
                            .foregroundColor(Color("AccentColor"))
                        Rectangle()
                            .fill(step.count > 10000 ? Color.green :Color.red)
                            .frame(width: 20, height: CGFloat(yValue))
                        Text("\(step.date,formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(Color("AccentColor"))
                    }
                }
                
            }
            
            Text("Amount of CO2 Reduced This Week:").padding(.top, 100)
                .foregroundColor(Color("AccentColor"))
            Text("\(convertStepstoCo2(steps: totalSteps))")
                .foregroundColor(Color("AccentColor"))
                .padding(.bottom)
            Button {
                self.showingDetail.toggle()
            } label: {
                Text("Life Time Reduction")
            }.foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color("AccentColor"))
                .cornerRadius(30)
                .sheet(isPresented: $showingDetail) {
                            TotalEmissionView(steps: steps)
                        }
            



        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(10)
        .padding(10)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let steps = [
                   Step(count: 3452, date: Date()),
                   Step(count: 123, date: Date()),
                   Step(count: 1223, date: Date()),
                   Step(count: 5223, date: Date()),
                   Step(count: 12023, date: Date())
               ]
        
        GraphView(steps: steps)
    }
}

func convertStepstoCo2 (steps : Int) -> String {
    let COtwo = (Float(steps)/2000) * 348
    return String(format: "%.2f", COtwo)
}
