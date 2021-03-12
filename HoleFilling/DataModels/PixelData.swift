//
//  PixelData.swift
//  HoleFilling
//
//  Created by Eugene Gordenstein on 3/11/21.
//

import Foundation

struct PixelData {
  var a: UInt8 = 0
  var r: UInt8 = 0
  var g: UInt8 = 0
  var b: UInt8 = 0
  
  init(grayValue: Float) {
    let safeValue = grayValue > 0 ? grayValue : 0
    a = 255
    r = UInt8(safeValue * 255)
    g = UInt8(safeValue * 255)
    b = UInt8(safeValue * 255)
  }
}
