//
//  HoleFillerHelpers.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/11/21.
//

import Foundation

extension HoleFiller {
  func getNeighbors(for coordinate: MatrixCoordinate) -> [MatrixCoordinate] {
    switch connectivity {
    case .fourConnected:
      return getFourConnectivityNeighbors(for: coordinate)
    case .eightConnected:
      return getEightConnectivityNeighbors(for: coordinate)
    }
  }
  
  func getFourConnectivityNeighbors(for coordinate: MatrixCoordinate) -> [MatrixCoordinate] {
    let i = coordinate.i
    let j = coordinate.j
    return [MatrixCoordinate(i: i - 1, j: j),
            MatrixCoordinate(i: i + 1, j: j),
            MatrixCoordinate(i: i, j: j + 1),
            MatrixCoordinate(i: i, j: j - 1)]
  }
  
  func getEightConnectivityNeighbors(for coordinate: MatrixCoordinate) -> [MatrixCoordinate] {
    let i = coordinate.i
    let j = coordinate.j
    return [MatrixCoordinate(i: i - 1, j: j - 1),
            MatrixCoordinate(i: i - 1, j: j),
            MatrixCoordinate(i: i - 1, j: j + 1),
            MatrixCoordinate(i: i, j: j - 1),
            MatrixCoordinate(i: i, j: j + 1),
            MatrixCoordinate(i: i + 1, j: j - 1),
            MatrixCoordinate(i: i + 1, j: j),
            MatrixCoordinate(i: i + 1, j: j + 1)]
  }
  
  func getSpiralTraverse<T>(matrix: [[T]]) -> [T] {
    guard matrix.count > 0 else {
      return []
    }
    
    var spiralTraverseArray = [T]()
    
    let rows = matrix.count
    var columns = 0
    for row in matrix {
      if row.count > columns {
        columns = row.count
      }
    }
    
    let pixels = rows * columns
    
    var direction = SpiralDirection.right
    var i = 0
    var j = 0
    
    var rightConstraint = columns
    var bottomConstraint = rows
    var leftConstraint = -1
    var topConstraint = -1
    
    var counter = 0
    
    while counter < pixels {
      if j < matrix[i].count {
        spiralTraverseArray.append(matrix[i][j])
      }
      counter += 1
      switch direction {
      case .right:
        if j == rightConstraint - 1 {
          i += 1
          topConstraint += 1
          direction = .down
        } else {
          j += 1
        }
      case .down:
        if i == bottomConstraint - 1 {
          j -= 1
          rightConstraint -= 1
          direction = .left
        } else {
          i += 1
        }
      case .left:
        if j == leftConstraint + 1 {
          i -= 1
          bottomConstraint -= 1
          direction = .up
        } else {
          j -= 1
        }
      case .up:
        if i == topConstraint + 1 {
          j += 1
          leftConstraint += 1
          direction = .right
        } else {
          i -= 1
        }
      }
    }
    return spiralTraverseArray
  }
  
  private enum SpiralDirection {
    case right
    case down
    case left
    case up
  }
}
