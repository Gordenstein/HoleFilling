//
//  ValidatorHelpers.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/12/21.
//

import Foundation

extension Validator {
  func printValidInputParameters(parameters: InputParameters) {
    print("""
    Your parameters:
      š imagePath: \(parameters.imagePath)
      š maskPath: \(parameters.maskPath)
      š zeta: \(parameters.zeta)
      š epsilon: \(parameters.epsilon)
      š connectivity: \(parameters.connectivity)
      š resultImagePath: \(parameters.resultImagePath)
    """)
  }
  
  func printInstruction() {
    print("\nš Hole Filling launch instructions")
    
    print("\nRequired parameters:")
    print("""
           1ļøā£ Original image path
           2ļøā£ Hole mask image path
           3ļøā£ Zeta value
           4ļøā£ Epsilon value
           5ļøā£ Pixel connectivity
           6ļøā£ Result image path
      """)
    
    var appPath = "./HoleFilling"
    if let path = CommandLine.arguments.first {
      appPath = path
    }
    
    print("\nCommand line call example:")
    print("""
           \(appPath) \\
           /Users/<username>/Documents/original.jpg \\
           /Users/<username>/Documents/holeMask.jpg \\
           2 \\
           0.0001 \\
           4 \\
           /Users/<username>/Documents/result.jpg
      """)
    
  }
}

