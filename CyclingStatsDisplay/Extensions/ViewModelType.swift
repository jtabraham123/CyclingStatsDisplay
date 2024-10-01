//
//  ViewModelType.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.

import Foundation

typealias ViewModelDefinition = (ObservableObject & Identifiable & Hashable)
// view model type definition, addded some conformities like Identifiable and Hashable for appending to navigation path
protocol ViewModelType: ViewModelDefinition {}

extension ViewModelType {
  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs === rhs
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
