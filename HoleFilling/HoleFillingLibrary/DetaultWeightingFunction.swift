//
//  DetaultWeightingFunction.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation

typealias WeightingFunction = (MatrixCoordinate, MatrixCoordinate) -> Float

func detaultWeightingFunction(zeta: Float, epsilon: Float) -> WeightingFunction {
  return { u, v in
    return 1 / (powf(euclideanDistance(for: u, and: v), zeta) + epsilon)
  }
}

fileprivate func euclideanDistance(for u: MatrixCoordinate, and v: MatrixCoordinate) -> Float {
  let uX = u.j
  let uY = u.i
  let vX = v.j
  let vY = v.i
  
  return sqrtf(powf(Float(uX - vX), 2) + powf(Float(uY - vY), 2))
}
