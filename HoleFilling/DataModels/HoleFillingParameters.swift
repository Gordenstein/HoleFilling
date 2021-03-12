//
//  HoleFillingParameters.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation

struct HoleFillingParameters {
  let originalGraySlaleMatrix: [[Float]]
  let maskGraySlaleMatrix: [[Float]]
  let zeta: Float
  let epsilon: Float
  let connectivity: PixelConnectivity
  let weightingFunction: WeightingFunction
}
