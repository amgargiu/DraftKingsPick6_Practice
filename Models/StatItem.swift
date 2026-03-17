//
//  StatItem.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/16/26.
//

import Foundation

// for the detail view
struct StatItem: Identifiable {
    let id : UUID =  UUID()
    let label: String
    let value: String
}
