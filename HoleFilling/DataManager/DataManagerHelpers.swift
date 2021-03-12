//
//  DataManagerHelpers.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/11/21.
//

import Foundation

extension DataManager {
  func getResultGray(red: UInt8, green: UInt8, blue: UInt8) -> Float {
    let redCoefficient: Float = 0.2126
    let greenCoefficient: Float = 0.7152
    let blueCoefficient: Float = 0.0722
    
    let redFloat = Float(red) / Float(255)
    let greenFloat = Float(green) / Float(255)
    let blueFloat = Float(blue) / Float(255)
    
    return redFloat * redCoefficient +
      greenFloat * greenCoefficient +
      blueFloat * blueCoefficient
  }
}
