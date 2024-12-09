//import AVFoundation
//import UIKit
//
//class CameraManager: NSObject {
//    static let shared = CameraManager()
//
//    // Make session public so ContentView can observe it
//    let session = AVCaptureSession()
//    private var output = AVCapturePhotoOutput()
//    private let sessionQueue = DispatchQueue(label: "CameraSessionQueue")
//
//    private var isSessionConfigured = false
//
//    override init() {
//        super.init()
//        configureSession()
//    }
//
//    private func configureSession() {
//        sessionQueue.async {
//            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
//                print("Error: No suitable video device available (front camera not found).")
//                return
//            }
//
//            do {
//                let input = try AVCaptureDeviceInput(device: device)
//                self.session.beginConfiguration()
//
//                if self.session.canAddInput(input) {
//                    self.session.addInput(input)
//                    print("Camera input added to session.")
//                } else {
//                    print("Error: Cannot add camera input to session.")
//                }
//
//                self.output = AVCapturePhotoOutput()
//                if self.session.canAddOutput(self.output) {
//                    self.session.addOutput(self.output)
//                    print("Camera output added to session.")
//                } else {
//                    print("Error: Cannot add photo output to session.")
//                }
//
//                self.session.commitConfiguration()
//                self.isSessionConfigured = true
//
//                // Start running inside the same sessionQueue to keep things synchronous
//                self.session.startRunning()
//                print("Camera session started.")
//            } catch {
//                print("Error: Failed to create AVCaptureDeviceInput - \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
//        sessionQueue.async {
//            guard self.isSessionConfigured && self.session.isRunning else {
//                print("Error: Capture session is not running or not properly configured.")
//                completion(nil)
//                return
//            }
//
//            let settings = AVCapturePhotoSettings()
//            self.output.capturePhoto(with: settings, delegate: PhotoCaptureProcessor(completion: completion))
//        }
//    }
//}
//
//
//class PhotoCaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate {
//    private let completion: (UIImage?) -> Void
//
//    init(completion: @escaping (UIImage?) -> Void) {
//        self.completion = completion
//    }
//
//    func photoOutput(_ output: AVCapturePhotoOutput,
//                     didFinishProcessingPhoto photo: AVCapturePhoto,
//                     error: Error?) {
//        guard let data = photo.fileDataRepresentation(),
//              let image = UIImage(data: data) else {
//            print("Error: Could not process captured photo.")
//            completion(nil)
//            return
//        }
//
//        print("Photo captured successfully.")
//        completion(image)
//    }
//}
