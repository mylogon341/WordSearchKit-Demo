//
//  CellFrameKey.swift
//  WordSearchSample
//
//  Created by luke on 27/11/2025.
//

import WordSearchKit
import SwiftUI

struct CellFrameKey: PreferenceKey {
  static var defaultValue: [GridPoint: CGRect] = [:]
  
  static func reduce(value: inout [GridPoint: CGRect],
                     nextValue: () -> [GridPoint: CGRect]) {
    
    value.merge(nextValue(), uniquingKeysWith: { $1 })
  }
}
