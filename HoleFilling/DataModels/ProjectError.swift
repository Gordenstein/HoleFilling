//
//  ProjectError.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/12/21.
//

import Foundation

enum ProjectError: LocalizedError {
  // Validator
  case missedParameters
  case excessParameters
  case wrongParametersFormat
  
  // DataManager
  case missedOriginalImage
  case missedMaskImage
  case couldNotProccessOriginalImage
  case couldNotProccessMaskImage
  case failedToCreateImageFromMatrix
  case failedSaveImage
  
  // HoleFiller
  case wrongMaskResolution
  
  
  var errorDescription: String {
    switch self {
    case .missedParameters:
      return "Some parameters are missed. Check the input parameters"
    case .excessParameters:
      return "There are excess parameters. Check the input parameters"
    case .wrongParametersFormat:
      return "Some parameters are in wrong format. Check the input parameters"
      
    case .missedOriginalImage:
      return "Could not find original image"
    case .missedMaskImage:
      return "Could not find mask image"
    case .couldNotProccessOriginalImage:
      return "Could not process gray scale matrix for original image"
    case .couldNotProccessMaskImage:
      return "Could not process gray scale matrix for mask image"
    case .failedToCreateImageFromMatrix:
      return "Failed to create result image from matrix"
    case .failedSaveImage:
      return "Failed to save result image"
      
    case .wrongMaskResolution:
      return "Wrong mask resulution"
    }
  }
}
