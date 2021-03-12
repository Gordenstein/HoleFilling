//
//  DataManager.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/10/21.
//

import Foundation
import AppKit

class DataManager {
  
  init() {
  }
  
  func getHoleFillingParameters(inputParameters: InputParameters) -> HoleFillingParameters? {
    guard let originalImage = NSImage(contentsOfFile: inputParameters.imagePath) else {
      print("Could not find original image")
      return nil
    }
    
    guard let maskImage = NSImage(contentsOfFile: inputParameters.maskPath) else {
      print("Could not find mask image")
      return nil
    }
    
    guard let originalGrayScaleMatrix = getGrayScaleMatrix(from: originalImage) else {
      print("Could not process gray scale matrix for original image")
      return nil
    }
    
    guard let maskGrayScaleMatrix = getGrayScaleMatrix(from: maskImage) else {
      print("Could not process gray scale matrix for mask image")
      return nil
    }
    
    let holeFillingParameters = HoleFillingParameters(originalGraySlaleMatrix: originalGrayScaleMatrix,
                                                      maskGraySlaleMatrix: maskGrayScaleMatrix,
                                                      zeta: inputParameters.zeta,
                                                      epsilon: inputParameters.epsilon,
                                                      connectivity: inputParameters.connectivity,
                                                      weightingFunction: inputParameters.weightingFunction)
    return holeFillingParameters
  }
  
  func getGrayScaleMatrix(from image: NSImage) -> [[Float]]? {
    let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
    guard let data = cgImage?.dataProvider?.data,
          var pointer = CFDataGetBytePtr(data) else {
      return nil
    }
    
    var matrix = [[Float]]()
    
    var red = UInt8()
    var green = UInt8()
    var blue = UInt8()
    
    let rows = Int(image.size.height)
    let columns = Int(image.size.width)
    
    for _ in 0..<rows {
      var currentRow = [Float]()
      for _ in 0..<columns {
        red = pointer.pointee
        pointer = pointer.advanced(by: 1)
        green = pointer.pointee
        pointer = pointer.advanced(by: 1)
        blue = pointer.pointee
        pointer = pointer.advanced(by: 2)
        
        let pixelValue: Float = getResultGray(red: red, green: green, blue: blue)
        currentRow.append(pixelValue)
      }
      matrix.append(currentRow)
    }
    return matrix
  }
  
  func convertToImageAndSave(matrix: [[Float]], path: String) {
    guard let image = getImageFromMatrix(matrix: matrix) else {
      return
    }
    
    save(image: image, filePath: path)
  }
    
  func getImageFromMatrix(matrix: [[Float]]) -> NSImage? {
    var mergedArray = [Float]()
    for row in matrix {
      mergedArray.append(contentsOf: row)
    }
    
    let pixels = mergedArray.map(PixelData.init(grayValue:))
    
    let rows = matrix.count
    let columns = matrix[0].count
    let pixelSize = MemoryLayout<PixelData>.size
    let bitsPerComponent = 8
    let bitsPerPixel = 32
    let bytesPerRow = columns * pixelSize
    let cgImageSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
    
    let data: Data = pixels.withUnsafeBufferPointer(Data.init(buffer:))
    let cfData = NSData(data: data) as CFData
    
    guard let provider = CGDataProvider(data: cfData),
          let cgImage = CGImage(width: columns,
                                height: rows,
                                bitsPerComponent: bitsPerComponent,
                                bitsPerPixel: bitsPerPixel,
                                bytesPerRow: bytesPerRow,
                                space: cgImageSpace,
                                bitmapInfo: bitmapInfo,
                                provider: provider,
                                decode: nil,
                                shouldInterpolate: true,
                                intent: .defaultIntent) else {
      return nil
    }
    
    let size = NSSize(width: columns, height: rows)
    let image = NSImage(cgImage: cgImage, size: size)
    return image
  }
  
  func save(image: NSImage, filePath: String) {
    guard let tiffRepresentation = image.tiffRepresentation else {
      return
    }
    
    let fileURL = URL(fileURLWithPath: filePath)
    let fileType = NSBitmapImageRep.FileType.jpeg
    
    try? NSBitmapImageRep(data: tiffRepresentation)?
      .representation(using: fileType, properties: [:])?
      .write(to: fileURL)
  }
}
