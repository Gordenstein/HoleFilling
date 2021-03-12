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
  
  func getHoleFillingParameters(inputParameters: InputParameters) throws -> HoleFillingParameters {
    guard let originalImage = NSImage(contentsOfFile: inputParameters.imagePath) else {
      throw ProjectError.missedOriginalImage
    }
    
    guard let maskImage = NSImage(contentsOfFile: inputParameters.maskPath) else {
      throw ProjectError.missedMaskImage
    }
    
    guard let originalGrayScaleMatrix = getGrayScaleMatrix(from: originalImage) else {
      throw ProjectError.couldNotProccessOriginalImage
    }
    
    guard let maskGrayScaleMatrix = getGrayScaleMatrix(from: maskImage) else {
      throw ProjectError.couldNotProccessMaskImage
    }
    
    let holeFillingParameters = HoleFillingParameters(originalGraySlaleMatrix: originalGrayScaleMatrix,
                                                      maskGraySlaleMatrix: maskGrayScaleMatrix,
                                                      connectivity: inputParameters.connectivity,
                                                      weightingFunction: inputParameters.weightingFunction)
    return holeFillingParameters
  }
  
  private func getGrayScaleMatrix(from image: NSImage) -> [[Float]]? {
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
  
  func convertToImageAndSave(matrix: [[Float]], path: String) throws {
    let image = try getImageFromMatrix(matrix: matrix)
    try save(image: image, filePath: path)
  }
    
  private func getImageFromMatrix(matrix: [[Float]]) throws -> NSImage {
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
      throw ProjectError.failedToCreateImageFromMatrix
    }
    
    let size = NSSize(width: columns, height: rows)
    let image = NSImage(cgImage: cgImage, size: size)
    return image
  }
  
  private func save(image: NSImage, filePath: String) throws {
    guard let tiffRepresentation = image.tiffRepresentation else {
      throw ProjectError.failedSaveImage
    }
    
    let fileURL = URL(fileURLWithPath: filePath)
    let fileType = NSBitmapImageRep.FileType.jpeg
    
    try NSBitmapImageRep(data: tiffRepresentation)?
      .representation(using: fileType, properties: [:])?
      .write(to: fileURL)
  }
}
