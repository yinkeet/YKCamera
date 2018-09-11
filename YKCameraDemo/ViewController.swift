//
//  ViewController.swift
//  YKCameraDemo
//
//  Created by Yin Keet on 26/08/2018.
//  Copyright © 2018 Lancet. All rights reserved.
//

import AVFoundation
import UIKit
import YKCamera

class ViewController: UIViewController {

//    let camera = YKPhotoCamera()
    let camera = YKVideoCamera()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        camera.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        camera.start { (error) in
            if let error = error {
                print(error)
            } else {
                self.camera.setViewFinder(on: self.view)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraPositionChange(sender: UISegmentedControl) {
        self.camera.stop();
        if sender.selectedSegmentIndex == 0 {
            camera.cameraPosition = AVCaptureDevice.Position.front
        } else if sender.selectedSegmentIndex == 1 {
            camera.cameraPosition = AVCaptureDevice.Position.back
        }
        camera.start { (error) in
            if let error = error {
                print(error)
            }
        }
    }

}

