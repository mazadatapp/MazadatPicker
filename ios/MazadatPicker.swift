//
//  MazadatPicker.swift
//  MazadatPicker
//
//  Created by Karim Saad on 15/11/2022.
//

import Foundation

@objc(MazadatPicker)
class MazadatPicker: NSObject{
  private var count=0
  @objc
  func increment(){
    count+=1;
    //resolve(count)
  }
  
   @objc
  func openCamera(_ title_:String,aspect_ratio_x:Int,aspect_ratio_y:Int,promise:@escaping RCTPromiseResolveBlock,reject:@escaping RCTPromiseRejectBlock){
    DispatchQueue.main.async {
      let cameraContoller = CameraController(nibName: "CameraController", bundle: nil)
      cameraContoller.modalPresentationStyle = .fullScreen
      cameraContoller.setData(title_: title_, aspectRatioX_: Float(aspect_ratio_x), aspectRatioY_: Float(aspect_ratio_y))
      cameraContoller.setPromise(promise: promise)
      UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(cameraContoller, animated: true, completion: nil)
    }
        
         print("open camera");
  }
  @objc
  func openGallery(_ title_:String,aspect_ratio_x:Int,aspect_ratio_y:Int,promise:@escaping RCTPromiseResolveBlock,reject:@escaping RCTPromiseRejectBlock){
    DispatchQueue.main.async {
      let controller = Gallery(nibName: "Gallery", bundle: nil)
      controller.modalPresentationStyle = .fullScreen
      controller.setData(title_: title_, aspectRatioX_: Float(aspect_ratio_x), aspectRatioY_: Float(aspect_ratio_y))
      controller.setPromise(promise: promise)
      UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
   
    }
     
   
   
    print("open gallery");
  }
      
  @objc
  func editImage(_ path_:String, title_:String,aspect_ratio_x:Int,aspect_ratio_y:Int,promise: @escaping RCTPromiseResolveBlock, reject:@escaping RCTPromiseRejectBlock){
    DispatchQueue.main.async {
      let controller = EditPhoto(nibName: "EditPhoto", bundle: nil)
      controller.modalPresentationStyle = .fullScreen
      controller.setData(title_: title_, aspectRatioX_: Float(aspect_ratio_x), aspectRatioY_: Float(aspect_ratio_x), fileName: URL(string: path_)!, from: "edit")
      controller.setPromise(promise: promise)
      UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(controller, animated: true, completion: nil)
      
    }
    print("open camera");
  }
}
