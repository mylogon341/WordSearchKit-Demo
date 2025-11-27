//
//  ContentView.swift
//  WordSearchSample
//
//  Created by luke on 27/11/2025.
//

import SwiftUI
import WordSearchKit

struct ContentView: View {
  
  private let coordinateSpaceName = "grid"
  
  @StateObject var viewModel = ContentViewModel()
  @State private var cellFrames: [GridPoint: CGRect] = [:]
  
  @State private var startPoint: GridPoint?
  
  @ViewBuilder
  func cellView(storage: [[Character]], row: Int, col: Int) -> some View {
    
    let point = GridPoint(row: row, column: col)
    
    Text(String(storage[row][col]))
      .frame(width: 30, height: 30)
      .background(.thinMaterial)
      .cornerRadius(4)
      .border(point == startPoint ? .blue : .clear, width: 2)
      .background(
        GeometryReader { geo in
          Color.clear
            .preference(key: CellFrameKey.self,
                        value: [
                          GridPoint(row: row, column: col):
                            geo.frame(in: .named(coordinateSpaceName))
                        ])
        }
      )
      .onTapGesture {
        
        if let startPoint {
          viewModel.userEndedGesture(start: startPoint, end: point)
          self.startPoint = nil
        } else {
          startPoint = point
        }
      }
  }
  
  @ViewBuilder
  var wordListView: some View {
    VStack {
      
      Text("Words")
        .underline()
      
      ForEach(viewModel.wordsToFind, id: \.self) { word in
      
        let found = viewModel.wordIsFound(word)
        
        Text(word)
          .strikethrough(found,color: .red)
      }
    }
  }
  
  var body: some View {
    
    wordListView
    
    ZStack {
      Grid {
        
        if let gridStorage = viewModel.wordSearchGrid?.storage {
          
          ForEach(gridStorage.indices, id: \.self) { row in
            
            GridRow {
              ForEach(gridStorage[row].indices, id: \.self) { col in
                
                cellView(storage: gridStorage, row: row, col: col)
              }
            }
          }
        }
      }
      
      FoundWordOverlayView(foundWords: viewModel.foundWords,
                           frames: cellFrames)
        .allowsHitTesting(false)
      
    }
    .coordinateSpace(name: coordinateSpaceName)
    .onPreferenceChange(CellFrameKey.self) { frames in
      self.cellFrames = frames
    }
    .padding()
    
  }
}

#Preview {
  ContentView()
}
