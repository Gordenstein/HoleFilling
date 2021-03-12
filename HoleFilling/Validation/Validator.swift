//
//  Validator.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation

class Validator {
  init() {
  }
  
  func validateInputArguments(arguments: [String]) throws -> InputParameters {
    let utilityArguments = arguments.count - 1
    if utilityArguments < 6 {
      throw ProjectError.missedParameters
    } else if utilityArguments > 6 {
      throw ProjectError.excessParameters
    }
    
    guard let zeta = Float(arguments[3]),
          let epsilon = Float(arguments[4]),
          let relatedPixels = Int(arguments[5]) else {
      throw ProjectError.wrongParametersFormat
    }
    
    let imagePath = arguments[1]
    let holePath = arguments[2]
    let resultImagePath = arguments[6]
    
    var connectivity = PixelConnectivity.fourConnected
    if relatedPixels == 8 {
      connectivity = .eightConnected
    }
    
    return InputParameters(imagePath: imagePath,
                           maskPath: holePath,
                           zeta: zeta,
                           epsilon: epsilon,
                           connectivity: connectivity,
                           weightingFunction: detaultWeightingFunction(zeta: zeta, epsilon: epsilon),
                           resultImagePath: resultImagePath)
  }
}
