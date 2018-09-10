//
//  YKPhotoCamera.swift
//  YKCamera
//
//  Created by Yin Keet on 26/08/2018.
//  Copyright © 2018 Lancet. All rights reserved.
//

import AVFoundation
import UIKit

open class YKPhotoCamera: YKAbstractCamera {
    
    override func configureOutput() throws {
        let captureOutput = AVCapturePhotoOutput()
        captureOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
        self.captureOutput = captureOutput
    }
    
}
