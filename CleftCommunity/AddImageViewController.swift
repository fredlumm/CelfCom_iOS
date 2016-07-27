//
//  AddImageViewController.swift
//  CleftCommunity
//  The view that let user to add image of a new post.
//  Created by ShuaiFu on 15/11/21.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate, UIPopoverPresentationControllerDelegate {
    
    var imageView: UIImageView!
    var image: UIImage!
    var addButton: UIButton!
    var chooseImageView: UIView!
    var darkView: UIView!
    var cfcam: UIButton!
    var cfpho: UIButton!
    var cancel: UIButton!
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        myPost = Thread()

        // Initialize each component
        imageView = UIImageView(frame: CGRectMake(self.view.frame.width*0.2, self.view.frame.height*0.2, self.view.frame.width*0.6, self.view.frame.width*0.6))
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        image = UIImage(named: "love.jpg")
        imageView.image = image
        self.view.addSubview(imageView)
        addButton = UIButton(type: UIButtonType.Custom)
        addButton.frame = CGRectMake(self.view.frame.width*0.2, self.view.frame.height*0.2, self.view.frame.width*0.6, self.view.frame.width*0.6)
        addButton.tag = 1
        addButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(addButton)
        chooseImageView = UIView(frame: CGRectMake(0, self.view.frame.height*0.7, self.view.frame.width, self.view.frame.height*0.3))
        chooseImageView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        cfcam = UIButton(frame: CGRectMake(chooseImageView.frame.width*0.2, chooseImageView.frame.height*0.1, chooseImageView.frame.width*0.6, chooseImageView.frame.height*0.2))
        cfcam.tag = 3
        cfcam.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        cfcam.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cfcam.setTitle("Camera", forState: UIControlState.Normal)
        cfcam.backgroundColor = UIColor.whiteColor()
        chooseImageView.addSubview(cfcam)
        cfpho = UIButton(frame: CGRectMake(chooseImageView.frame.width*0.2, chooseImageView.frame.height*0.35, chooseImageView.frame.width*0.6, chooseImageView.frame.height*0.2))
        cfpho.tag = 2
        cfpho.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        cfpho.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cfpho.setTitle("Photo", forState: UIControlState.Normal)
        cfpho.backgroundColor = UIColor.whiteColor()
        chooseImageView.addSubview(cfpho)
        cancel = UIButton(frame: CGRectMake(chooseImageView.frame.width*0.2, chooseImageView.frame.height*0.7, chooseImageView.frame.width*0.6, chooseImageView.frame.height*0.2))
        cancel.tag = 4
        cancel.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        cancel.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cancel.setTitle("Cancel", forState: UIControlState.Normal)
        cancel.backgroundColor = UIColor.darkGrayColor()
        chooseImageView.addSubview(cancel)
    }
    
    func buttonAction(sender: UIButton){
        if sender.tag == 1 {
            let optionMenu = UIAlertController(title: nil, message: "Upload image from", preferredStyle: .ActionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler:{
                (alert:UIAlertAction!) -> Void in
                var sourceType = UIImagePickerControllerSourceType.Camera
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                    sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                }
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = sourceType
                self.presentViewController(picker, animated: true, completion: nil)
            })
            let albumAction = UIAlertAction(title: "Album", style: .Default, handler:{
                (alert:UIAlertAction!) -> Void in
                let pickerImage = UIImagePickerController()
                if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                    pickerImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                    pickerImage.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(pickerImage.sourceType)!
                }
                pickerImage.delegate = self
                pickerImage.allowsEditing = true
                self.presentViewController(pickerImage, animated: true, completion: nil)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler:{
                (alert:UIAlertAction!) -> Void in
                //print("Test Delte")
            })
            optionMenu.addAction(cameraAction)
            optionMenu.addAction(albumAction)
            optionMenu.addAction(cancelAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = image
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        myPost.pic = imageData!
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
