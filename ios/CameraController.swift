//
//  CameraController.swift
//  TestCamera
//
//  Created by Karim Saad on 01/11/2022.
//

import UIKit
import SwiftyCam
import TAOverlayView
class CameraController: SwiftyCamViewController,SwiftyCamViewControllerDelegate {

    @IBOutlet weak var back_button: UIButton!
    var overlayView: TAOverlayView?
  
    @IBOutlet weak var retake_next_view: UIView!
  
    @IBOutlet weak var title_view: UIView!
    @IBOutlet weak var title_: UILabel!
    
  @IBOutlet weak var capture_button: UIButton!
  @IBOutlet weak var flip_button: UIButton!
  @IBOutlet weak var flash_button: UIButton!
  @IBOutlet weak var captured_photo: UIImageView!
    
  var capturedImage:UIImage!
  var isFront=true
  var flashOn=false;
  var fileName:URL!
  
  var title_text=""
  var aspectRatioX:Float!
  var aspectRatioY:Float!
  var promise:RCTPromiseResolveBlock!
  override func viewDidLoad() {
      super.viewDidLoad()
      cameraDelegate = self
    let width=UIScreen.main.bounds.width*2.6/3.0
    let height=Float(width)*aspectRatioY/aspectRatioX
    
    title_.text=title_text
    
    let overlay = TAOverlayView(frame: CGRect(x: 0, y: 0,
          width: UIScreen.main.bounds.width,
          height: UIScreen.main.bounds.height), subtractedPaths: [
            TARectangularSubtractionPath(frame: CGRect(x: UIScreen.main.bounds.width/2 - width/2, y: UIScreen.main.bounds.height/2 - CGFloat(height)/2, width: width, height: CGFloat(height)),    // Use a rectangular hole.
      horizontalPadding: 10.0, verticalPadding: 5.0)             // More padding on the left/right than the top/bottom
      ])
    
      // Add as subview.
      self.view.addSubview(overlay)

      // Set a reference to the overlay (to hide, add more holes, etc.).
      self.overlayView = overlay
    flash_button.setTitle("", for: .normal)
    flip_button.setTitle("", for: .normal)
    capture_button.setTitle("", for: .normal)
    back_button.setTitle("", for: .normal)
    
    self.view.bringSubviewToFront(flash_button)
    self.view.bringSubviewToFront(flip_button)
    self.view.bringSubviewToFront(capture_button)
    self.view.bringSubviewToFront(title_view)
    self.view.bringSubviewToFront(back_button)
        // Do any additional setup after loading the view.
    }
  
  open func setData(title_:String,aspectRatioX_: Float ,aspectRatioY_: Float){
    self.title_text=title_
    self.aspectRatioX=aspectRatioX_
    self.aspectRatioY=aspectRatioY_
  }
  open func setPromise(promise:RCTPromiseResolveBlock!){
    self.promise=promise
  }
  
  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
    
    capturedImage = photo
    
    overlayView?.isHidden=true;
    captured_photo.isHidden=false
    retake_next_view.isHidden=false

    flash_button.isHidden=true
    flip_button.isHidden=true
    capture_button.isHidden=true
    
    captured_photo.image=photo
    
    showPreviewLayer(flag: false)
    
    self.view.bringSubviewToFront(captured_photo)
    self.view.bringSubviewToFront(title_view)
    self.view.bringSubviewToFront(retake_next_view)
    self.view.bringSubviewToFront(back_button)
       // Called when takePhoto() is called or if a SwiftyCamButton initiates a tap gesture
       // Returns a UIImage captured from the current session
  }

  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
       // Called when startVideoRecording() is called
       // Called if a SwiftyCamButton begins a long press gesture
  }

  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
       // Called when stopVideoRecording() is called
       // Called if a SwiftyCamButton ends a long press gesture
  }

  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
       // Called when stopVideoRecording() is called and the video is finished processing
       // Returns a URL in the temporary directory where video is stored
  }

  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
       // Called when a user initiates a tap gesture on the preview layer
       // Will only be called if tapToFocus = true
       // Returns a CGPoint of the tap location on the preview layer
  }

  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
      // Called when a user initiates a pinch gesture on the preview layer
      // Will only be called if pinchToZoomn = true
      // Returns a CGFloat of the current zoom level
  }

  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
       // Called when user switches between cameras
       // Returns current camera selection
  }

    @IBAction func backPressed(_ sender: UIButton) {
      dismiss(animated: true)
    }
    
  @IBAction func capturePressed(_ sender: UIButton) {
    takePhoto()
  }
  
  @IBAction func flashPressed(_ sender: UIButton) {
    flashOn = !flashOn
    
    if(isFront){
      flashMode = .on
    }else{
      flashMode = .off
    }
      
  }
  
  @IBAction func flipPressed(_ sender: UIButton) {
    switchCamera()
  }
  
    
    @IBAction func retakePressed(_ sender: UIButton) {
      
      overlayView?.isHidden=false;
      captured_photo.isHidden=true
      retake_next_view.isHidden=true

      flash_button.isHidden=false
      flip_button.isHidden=false
      capture_button.isHidden=false
      
      showPreviewLayer(flag: true)
      self.view.bringSubviewToFront(back_button)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
      fileName = capturedImage.saveImage(name: "photo.png")
      print(fileName.path)
      dismiss(animated: true)
      let controller=EditPhoto(nibName: "EditPhoto", bundle: nil)
      controller.setData(title_: title_text, aspectRatioX_: aspectRatioX, aspectRatioY_: aspectRatioY, fileName: fileName, from: "gallery")
      controller.setPromise(promise: promise)
      controller.modalPresentationStyle = .fullScreen
      self.present(controller, animated: true, completion: nil)
    }
    
   
}
