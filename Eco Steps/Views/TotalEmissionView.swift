//
//  TotalEmissionView.swift
//  Eco Steps
//
//  Created by Mai Dang on 3/11/23.
//

import SwiftUI

struct TotalEmissionView: View {
    let steps: [Step]
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    var body: some View {
        Text("Total CO2 Emission:")
            .font(.title)
            .foregroundColor(Color("AccentColor"))
        Text(convertStepstoCo2(steps: totalSteps))
            .font(.title)
            .foregroundColor(Color("AccentColor"))
        Image("appstore")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .padding(.top)
    }
}

struct TotalEmissionView_Previews: PreviewProvider {
    static var previews: some View {
        TotalEmissionView(steps: [])
    }
}
