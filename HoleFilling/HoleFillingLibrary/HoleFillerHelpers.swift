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
}
