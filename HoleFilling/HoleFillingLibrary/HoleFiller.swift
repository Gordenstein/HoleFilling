//
//  HoleFiller.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation

class HoleFiller {
  var originalGraySlaleMatrix: [[Float]]
  var maskGraySlaleMatrix: [[Float]]
  var connectivity: PixelConnectivity
  var weightingFunction: WeightingFunction
    
  init() {
    originalGraySlaleMatrix = [[Float]]()
    maskGraySlaleMatrix = [[Float]]()
    connectivity = PixelConnectivity.eightConnected
    weightingFunction = detaultWeightingFunction(zeta: 2, epsilon: 0.0001)
  }
  
  func getFilledHoleMatrix(parameters: HoleFillingParameters) throws -> [[Float]] {
    configureFiller(with: parameters)
    
    let holeInformation = try applyMaskOnImageAndGetHoleInformation()
    
    fillHole(holeInformation: holeInformation)
    
    return originalGraySlaleMatrix
  }
  
  func configureFiller(with parameters: HoleFillingParameters) {
    originalGraySlaleMatrix = parameters.originalGraySlaleMatrix
    maskGraySlaleMatrix = parameters.maskGraySlaleMatrix
    connectivity = parameters.connectivity
    weightingFunction = parameters.weightingFunction
  }
  
  func applyMaskOnImageAndGetHoleInformation() throws -> HoleInformation {
    let rows = originalGraySlaleMatrix.count
    let columns = originalGraySlaleMatrix[0].count
    
    guard rows == maskGraySlaleMatrix.count,
          columns == maskGraySlaleMatrix[0].count else {
      throw ProjectError.wrongParametersFormat
    }
    
    var boundary = Set<MatrixCoordinate>()
    var holeBody = Set<MatrixCoordinate>()
    
    for i in 0..<rows {
      for j in 0..<columns {
        let isHole = maskGraySlaleMatrix[i][j] > 0.0
        let currentCoordinate = MatrixCoordinate(i: i, j: j)
        if isHole {
          originalGraySlaleMatrix[i][j] = -1
          holeBody.insert(currentCoordinate)
          let neibors = getNeighbors(for: currentCoordinate)
          for neibor in neibors {
            if neibor.i >= 0 && neibor.i < rows
                && neibor.j >= 0 && neibor.j < columns {
              let neiborIsHole = maskGraySlaleMatrix[neibor.i][neibor.j] > 0.0
              if !neiborIsHole {
                boundary.insert(neibor)
              }
            }
          }
        }
      }
    }
    
    return HoleInformation(boundary: boundary, holeBody: holeBody)
  }
  
  func fillHole(holeInformation: HoleInformation) {
    let boundary = holeInformation.boundary
    let holeBody = holeInformation.holeBody
    
    for u in holeBody {
      var dividend: Float = 0
      var divisor: Float = 0
      for v in boundary {
        let weight = weightingFunction(u, v)
        dividend += weight * originalGraySlaleMatrix[v.i][v.j]
        divisor += weight
      }
      let quotient = dividend / divisor
      originalGraySlaleMatrix[u.i][u.j] = quotient
    }
  }
}
