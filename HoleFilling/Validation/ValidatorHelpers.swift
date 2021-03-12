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
      🔘 imagePath: \(parameters.imagePath)
      🔘 maskPath: \(parameters.maskPath)
      🔘 zeta: \(parameters.zeta)
      🔘 epsilon: \(parameters.epsilon)
      🔘 connectivity: \(parameters.connectivity)
      🔘 resultImagePath: \(parameters.resultImagePath)
    """)
  }
  
  func printInstruction() {
    print("\n📖 Hole Filling launch instructions")
    
    print("\nRequired parameters:")
    print("""
           1️⃣ Original image path
           2️⃣ Hole mask image path
           3️⃣ Zeta value
           4️⃣ Epsilon value
           5️⃣ Pixel connectivity
           6️⃣ Result image path
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

