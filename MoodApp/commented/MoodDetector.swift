//
//  MoodDetector.swift
//  MoodApp
//
//  Created by Yasser Hajlaoui on 12/8/24.
//

//import Foundation
//import CoreML
//import Vision
//import UIKit
//
//class MoodDetector {
//    let model: EmotionDetection
//
//    // Adjust these indices according to the model’s output class order.
//    // For demonstration:
//    // 0 = happy
//    // 1 = angry
//    // Others = neutral
//    let HAPPY_INDEX = 0
//    let ANGRY_INDEX = 1
//
//    init() {
//        let configuration = MLModelConfiguration()
//        configuration.computeUnits = .cpuOnly
//        model = try! EmotionDetection(configuration: configuration)
//    }
//
//    func analyzeMood(from image: UIImage, completion: @escaping (Mood) -> Void) {
//        print("Analyzing mood from image...")
//
//        guard let pixelBuffer = image.pixelBuffer(width: 48, height: 48) else {
//            print("Failed to convert UIImage to pixel buffer.")
//            completion(.neutral)
//            return
//        }
//        print("Pixel buffer created successfully.")
//
//        guard let multiArray = try? MLMultiArray(shape: [1, 48, 48, 1], dataType: .float32) else {
//            print("Failed to create MLMultiArray.")
//            completion(.neutral)
//            return
//        }
//        print("MLMultiArray created successfully.")
//
//        fillMultiArray(from: pixelBuffer, into: multiArray)
//
//        guard let prediction = try? model.prediction(conv2d_1_input: multiArray) else {
//            print("Failed to predict mood.")
//            completion(.neutral)
//            return
//        }
//
//        print("Prediction successful. Raw output: \(prediction.Identity)")
//
//        // Extract the probability array (1 x 19). We take the first row [0] which gives us a 1D slice.
//        let valuesSlice = prediction.IdentityShapedArray[0]
//        
//        // Convert the MLShapedArraySlice<Float> into a standard [Float].
//        let floatValues: [Float] = (0..<valuesSlice.count).map { valuesSlice[scalarAt: $0] }
//
//        // Find the max value and its index.
//        guard let (maxIndex, maxValue) = floatValues.enumerated().max(by: { $0.element < $1.element }) else {
//            completion(.neutral)
//            return
//        }
//
//        print("MaxIndex: \(maxIndex), MaxValue: \(maxValue)")
//
//        // Threshold logic
//        if maxIndex == HAPPY_INDEX && maxValue > 0.8 {
//            print("Mood detected: Happy")
//            completion(.happy)
//        } else if maxIndex == ANGRY_INDEX && maxValue > 0.8 {
//            print("Mood detected: Angry")
//            completion(.angry)
//        } else {
//            print("Mood detected: Neutral")
//            completion(.neutral)
//        }
//    }
//
//    private func fillMultiArray(from pixelBuffer: CVPixelBuffer, into multiArray: MLMultiArray) {
//        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
//        defer {
//            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
//        }
//
//        guard let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer) else {
//            return
//        }
//
//        let width = CVPixelBufferGetWidth(pixelBuffer)
//        let height = CVPixelBufferGetHeight(pixelBuffer)
//        let rowBytes = CVPixelBufferGetBytesPerRow(pixelBuffer)
//
//        // Assuming single-channel grayscale data. If not, adjust accordingly.
//        for y in 0..<height {
//            for x in 0..<width {
//                let pixelPointer = baseAddress.assumingMemoryBound(to: UInt8.self) + y * rowBytes + x
//                let pixelValue = Float(pixelPointer.pointee) / 255.0
//                multiArray[[0, y, x, 0] as [NSNumber]] = NSNumber(value: pixelValue)
//            }
//        }
//    }
//}
