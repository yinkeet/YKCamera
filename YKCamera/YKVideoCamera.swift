//
//  YKVideoCamera.swift
//  YKCamera
//
//  Created by Yin Keet on 10/09/2018.
//  Copyright © 2018 Lancet. All rights reserved.
//

import AVFoundation
import UIKit

open class YKVideoCamera: YKAbstractCamera, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    open weak var delegate: YKVideoCameraDelegate?
    
    override func configureOutput() throws {
        let captureOutput = AVCaptureVideoDataOutput()
        captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] as [String : Any]
        captureOutput.alwaysDiscardsLateVideoFrames = true
        let queue = DispatchQueue(label: "com.lancet.ykcamera.ykvideocamera.queue")
        captureOutput.setSampleBufferDelegate(self, queue: queue)
        self.captureOutput = captureOutput
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.captureOutput(didOutput: sampleBuffer, from: connection)
    }
}

open protocol YKVideoCameraDelegate: class {
    func captureOutput(didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    func captureOutput(didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
}
