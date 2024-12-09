//
//  UIImage+PixelBuffer.swift
//  MoodApp
//
//  Created by Yasser Hajlaoui on 12/8/24.
//
//
//import UIKit
//import CoreVideo

//extension UIImage {
//    func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
//        let attributes: [CFString: Any] = [
//            kCVPixelBufferCGImageCompatibilityKey: true,
//            kCVPixelBufferCGBitmapContextCompatibilityKey: true
//        ]
//
//        var pixelBuffer: CVPixelBuffer?
//        let status = CVPixelBufferCreate(
//            kCFAllocatorDefault,
//            width,
//            height,
//            kCVPixelFormatType_OneComponent8, // grayscale format
//            attributes as CFDictionary,
//            &pixelBuffer
//        )
//
//        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
//            print("Error: Could not create pixel buffer.")
//            return nil
//        }
//
//        CVPixelBufferLockBaseAddress(buffer, [])
//
//        guard let baseAddress = CVPixelBufferGetBaseAddress(buffer) else {
//            print("Error: Could not get base address of pixel buffer.")
//            CVPixelBufferUnlockBaseAddress(buffer, [])
//            return nil
//        }
//
//        guard let cgImage = self.cgImage else {
//            print("Error: Could not get cgImage from UIImage.")
//            CVPixelBufferUnlockBaseAddress(buffer, [])
//            return nil
//        }
//
//        guard let context = CGContext(
//            data: baseAddress,
//            width: width,
//            height: height,
//            bitsPerComponent: 8,
//            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
//            space: CGColorSpaceCreateDeviceGray(),
//            bitmapInfo: CGImageAlphaInfo.none.rawValue
//        ) else {
//            print("Error: Could not create CGContext.")
//            CVPixelBufferUnlockBaseAddress(buffer, [])
//            return nil
//        }
//
//        // Draw the image into the context, scaling to the specified width & height
//        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//
//        CVPixelBufferUnlockBaseAddress(buffer, [])
//        return buffer
//    }
//}
