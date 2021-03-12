//
//  InputParameters.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation

struct InputParameters {
  let imagePath: String
  let maskPath: String
  let zeta: Float
  let epsilon: Float
  let connectivity: PixelConnectivity
  let weightingFunction: WeightingFunction
  let resultImagePath: String
}
