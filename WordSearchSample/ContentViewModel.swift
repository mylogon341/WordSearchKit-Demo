//
//  ContentViewModel.swift
//  WordSearchSample
//
//  Created by luke on 27/11/2025.
//

import Foundation
import WordSearchKit
import Combine

class ContentViewModel: ObservableObject {

  @Published var wordSearchGrid: Grid?
  var wordsToFind: [String] = ["swift", "apple", "banana", "orange", "cherry"]
  @Published var foundWords: [PlacedWord] = []
  
  init() {
    setupGrid()
  }
  
  func wordIsFound(_ word: String) -> Bool {
    foundWords
      .map( \.word)
      .contains(where: {
      $0.caseInsensitiveCompare(word) == .orderedSame
    })
  }
  
  private func setupGrid() {
    
    do {
      wordSearchGrid = try WordSearchKit.generate(
        .init(rows: 10, columns: 10, words: wordsToFind)
      )
    } catch let error {
      print("error generating grid: \(error)")
    }
  }
  
  func userEndedGesture(start: GridPoint, end: GridPoint) {
    
    if let wordSearchGrid,
       let found = WordSearchKit.checkPoints(grid: wordSearchGrid, start: start, end: end) {
      
      print("found: \(found.word)")
      foundWords.append(found)
    }
    
  }
  
}

