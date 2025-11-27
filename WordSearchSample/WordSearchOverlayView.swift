//
//  WordSearchOverlayView.swift
//  WordSearchSample
//
//  Created by luke on 27/11/2025.
//

import SwiftUI
import WordSearchKit

struct FoundWordOverlayView: View {
  let foundWords: [PlacedWord]
  let frames: [GridPoint: CGRect]
  
  var body: some View {
    Canvas { context, size in
      for word in foundWords {
        
        let gridPoints = word.allPoints
        
        
        if let first = gridPoints.first,
           let last = gridPoints.last,
           let startFrame = frames[first],
           let endFrame = frames[last] {
          
          let start = CGPoint(
            x: startFrame.midX,
            y: startFrame.midY
          )
          
          let end = CGPoint(
            x: endFrame.midX,
            y: endFrame.midY
          )
          
          var path = Path()
          path.move(to: start)
          path.addLine(to: end)
          
          context.stroke(
            path,
            with: .color(.blue),
            lineWidth: 3
          )
        }
      }
    }
  }
}
