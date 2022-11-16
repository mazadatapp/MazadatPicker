//
//  Gallery.swift
//  TestCamera
//
//  Created by Karim Saad on 02/11/2022.
//

import UIKit
import NohanaImagePicker
import Photos
class Gallery: UIViewController,NohanaImagePickerControllerDelegate {
  var title_text=""
  var aspectRatioX:Float!
  var aspectRatioY:Float!
  var fileName:URL!
    var promise:RCTPromiseResolveBlock!
  var picker = NohanaImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Do any additional setup after loading the view.
    }
  
  override func viewDidAppear(_ animated: Bool) {
   self.picker.delegate = self
   picker.maximumNumberOfSelection=10
   picker.shouldShowMoment = true
    
   
    present(self.picker, animated: true, completion: nil)
  }
  
  open func setData(title_:String,aspectRatioX_: Float ,aspectRatioY_: Float){
    self.title_text=title_
    self.aspectRatioX=aspectRatioX_
    self.aspectRatioY=aspectRatioY_
  }
  
  open func setPromise(promise:RCTPromiseResolveBlock!){
    self.promise=promise
  }
  
 func nohanaImagePickerDidCancel(_ picker: NohanaImagePickerController) {
         print("🐷Canceled🙅")
         picker.dismiss(animated: true, completion: {
           self.dismiss(animated: false)
         })

     }

     func nohanaImagePicker(_ picker: NohanaImagePickerController, didFinishPickingPhotoKitAssets pickedAssts :[PHAsset]) {
        // print("🐷Completed🙆\n\tpickedAssets = \(pickedAssts)")
         picker.dismiss(animated: true, completion: nil)
       var index=0
       var paths=""
       let count = pickedAssts.count
       for asset : PHAsset in pickedAssts{
           asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { (eidtingInput, info) in
               if let input = eidtingInput, let photoUrl = input.fullSizeImageURL {
                   //print(photoUrl)
                 if(count==1){
                   self.dismiss(animated: true)
                   let controller=EditPhoto(nibName: "EditPhoto", bundle: nil)
                   controller.setData(title_: self.title_text, aspectRatioX_: self.aspectRatioX, aspectRatioY_: self.aspectRatioY, fileName: photoUrl, from: "gallery")
                     controller.setPromise(promise: self.promise)
                   controller.modalPresentationStyle = .fullScreen
                   self.present(controller, animated: true, completion: nil)

                 }else{
                   index+=1
                   print("here")
                   print(photoUrl.path)
                   paths += photoUrl.path+","

                   if(index==count){
                     paths=String(paths.dropLast(1))
                     print("all "+paths)
                     self.promise([paths])
                     self.dismiss(animated: true)
                   }
                 }
               }
           }
       }

     }
  
  
  

  
  
  
}
