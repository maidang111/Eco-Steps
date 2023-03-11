//
//  Step.swift
//  Eco Steps
//
//  Created by Mai Dang on 3/11/23.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
