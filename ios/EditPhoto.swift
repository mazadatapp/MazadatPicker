//
//  EditPhoto.swift
//  TestCamera
//
//  Created by Karim Saad on 02/11/2022.
//

import UIKit

class EditPhoto: UIViewController {
    
  @IBOutlet weak var cropView: CropperView!
  @IBOutlet weak var title_view: UIView!
  @IBOutlet weak var title_: UILabel!
  @IBOutlet weak var back_button: UIButton!
  
  @IBOutlet weak var zoom_image_height: NSLayoutConstraint!
  @IBOutlet weak var zoom_view: UIView!
  @IBOutlet weak var image_zoom: UIImageView!
  @IBOutlet weak var rotate_left_button: UIButton!
  @IBOutlet weak var rotate_right_button: UIButton!
    
  @IBOutlet weak var zoom_out_button: UIButton!
  var from=""
  var title_text=""
  var aspectRatioX:Float!
  var aspectRatioY:Float!
  var fileName:URL!
  var step=0
  var promise:RCTPromiseResolveBlock!
  override func viewDidLoad() {
        super.viewDidLoad()
        
    back_button.setTitle("", for: .normal)
    rotate_left_button.setTitle("", for: .normal)
    rotate_right_button.setTitle("", for: .normal)
    zoom_out_button.setTitle("", for: .normal)
    
    title_.text=title_text
    
    if(from == "camera"){
     // image_.image=UIImage(contentsOfFile: fileName.path)!.rotate(radians: .pi/2)
    }
        // Do any additional setup after loading the view.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    cropView.setImage(image: UIImage(contentsOfFile: fileName.path)!)
  }

  open func setData(title_:String,aspectRatioX_: Float ,aspectRatioY_: Float,fileName:URL,from:String){
    self.title_text=title_
    self.aspectRatioX=aspectRatioX_
    self.aspectRatioY=aspectRatioY_
    self.fileName=fileName
    self.from=from
  }
    open func setPromise(promise:RCTPromiseResolveBlock!){
      self.promise=promise
    }
  @IBAction func backPressed(_ sender: UIButton) {
      dismiss(animated: true)
  }
    
    @IBAction func rotateLefttPressed(_ sender: UIButton) {
      cropView.rotateLeft()
    }
    
    @IBAction func rotateRightPressed(_ sender: UIButton) {
      cropView.rotateRight()
    }
    @IBAction func zoomOutPressed(_ sender: UIButton) {
      cropView.zoomOut()
      rotate_left_button.isHidden=true
      rotate_right_button.isHidden=true
    }
  
    @IBAction func nextPressed(_ sender: UIButton) {
      if(step==0){
          image_zoom.image=UIImage(cgImage: cropView.getCroppedImage().cgImage!)
          zoom_view.isHidden=false
         
          cropView.isHidden=true
          
          image_zoom.enableZoom()
          zoom_image_height.constant = zoom_view.frame.width * CGFloat(aspectRatioY/aspectRatioX)
        
          rotate_left_button.isHidden=true
          rotate_right_button.isHidden=true
          zoom_out_button.isHidden=true
      }else if(step==1){
          let image = zoom_view.snapshot(of: zoom_view.bounds, afterScreenUpdates: false)
//          finalImage.isHidden=false
//          zoomView.isHidden=true
          //finalImage.image = image
        var fileName=image.saveImage(name: "photo.png")
        
        promise(fileName.path)
        dismiss(animated: true)
      }
      step+=1
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
