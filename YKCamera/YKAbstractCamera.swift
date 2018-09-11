//
//  YKAbstractCamera.swift
//  YKCamera
//
//  Created by Yin Keet on 26/08/2018.
//  Copyright © 2018 Lancet. All rights reserved.
//

import AVFoundation
import UIKit

open class YKAbstractCamera: NSObject {
    
    public var cameraPosition = AVCaptureDevice.Position.back
    
    var captureSession: AVCaptureSession
    var previousCaptureDeviceInput: AVCaptureDeviceInput?
    var currentCaptureDeviceInput: AVCaptureDeviceInput?
    var captureOutput: AVCaptureOutput?
    
    open private(set) var previewLayer: AVCaptureVideoPreviewLayer
    
    override public init() {
        self.captureSession = AVCaptureSession()
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    }
    
    func configureOutput() throws {
        fatalError("Subclasses need to implement the `configureOutput()` method.")
    }
    
}

extension YKAbstractCamera {
    
    enum YKAbstractCameraError: Error {
        case captureSessionIsNotRunning
        case noCamerasAvailable
        case captureDeviceInputIsNull
        case captureOutputIsNull
    }
    
}

extension YKAbstractCamera {
    
    public func start(completionHandler: @escaping (Error?) -> Void) {
        
        func configureDeviceInput() throws {
            if let currentCaptureDeviceInput = self.currentCaptureDeviceInput {
                self.previousCaptureDeviceInput = currentCaptureDeviceInput
            }
            
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: self.cameraPosition)
            let devices = session.devices.compactMap { $0 }
            
            for device in devices {
                switch device.position {
                case .front:
                    self.currentCaptureDeviceInput = try AVCaptureDeviceInput(device: device)
                    break
                case .back:
                    try device.lockForConfiguration()
                    device.focusMode = .continuousAutoFocus
                    device.unlockForConfiguration()
                    
                    self.currentCaptureDeviceInput = try AVCaptureDeviceInput(device: device)
                    break
                case .unspecified: break
                }
            }
        }
        
        func configureCaptureSession() throws {
            guard let currentCaptureDeviceInput = self.currentCaptureDeviceInput else {
                throw YKAbstractCameraError.captureDeviceInputIsNull
            }
            guard let captureOutput = self.captureOutput else {
                throw YKAbstractCameraError.captureOutputIsNull
            }
            
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
            
            self.captureSession.beginConfiguration()
            
            if let previousCaptureDeviceInput = self.previousCaptureDeviceInput {
                self.captureSession.removeInput(previousCaptureDeviceInput)
            }
            if self.captureSession.canAddInput(currentCaptureDeviceInput) {
                self.captureSession.addInput(currentCaptureDeviceInput)
            }
            if self.captureSession.canAddOutput(captureOutput) {
                self.captureSession.addOutput(captureOutput)
            }
            
            self.captureSession.commitConfiguration()
            
            self.captureSession.startRunning()
        }
        
        DispatchQueue(label: "com.lancet.ykcamera.ykabstractcamera.setup").async {
            do {
                try configureDeviceInput()
                try self.configureOutput()
                try configureCaptureSession()
            } catch {
                DispatchQueue.main.async {
                    completionHandler(error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
        
    }
    
    public func stop() {
        self.captureSession.stopRunning();
    }
    
}

extension YKAbstractCamera {

    public func setViewFinder(on view: UIView) {
        view.layer.insertSublayer(self.previewLayer, at: 0)
        self.previewLayer.frame = view.bounds
    }
    
}
