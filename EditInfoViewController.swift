//
//  EditInfoViewController.swift
//  CleftCommunity
//  The table view that let user edit his own profile
//  Created by 宁伟晨 on 11/7/15.
//  Copyright © 2015 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

class EditInfoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var genderPick: UIPickerView!
    
    var selectItem = String()
    var mottoText: UITextField!
    var motto: UILabel!
    var phoneText: UITextField!
    var phone: UILabel!
    var ageText: UITextField!
    var age: UILabel!
    var emailText: UITextField!
    var email: UILabel!
    var regionText: UITextField!
    var region: UILabel!
    var nameText: UITextField!
    var name: UILabel!
    var addButton: UIButton!
    var imageView: UIImageView!
    var image: UIImage!
    var genderChoose = ["Male", "Female", "Not Specified"]
    var temp = myInfo.gender
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Show alert after press the save button
    @IBAction func saveEdit(sender: AnyObject) {
        if(selectItem == "Profile Photo"){
            if (imageView.image == nil) {
                let alert = UIAlertController(title: "Photo Required", message: "Please select a photo.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                let imageData = UIImageJPEGRepresentation(imageView.image!, 1.0)
                myInfo.photo = imageData
                let alert = UIAlertController(title: "Saved", message: "Modification has been saved.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else if(selectItem == "Name"){
            if(nameText.text!.characters.count>30){
                let alert = UIAlertController(title: "Character limits", message: "The maximum length is 20.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else if(nameText.text!.characters.count==0){
                let alert = UIAlertController(title: "Warning", message: "Nickname can't be empty.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                myInfo.nickname = nameText.text!
                nameText.resignFirstResponder()
                let alert = UIAlertController(title: "Saved", message: "Modification has been saved.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else if(selectItem == "Gender"){
            myInfo.gender = temp
            let alert = UIAlertController(title: "Saved", message: "Modification has been saved.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction) -> Void in
                })
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if(selectItem == "Age"){
            var flag = false
            let temp = ageText.text!
            for char in temp.utf8  {
                if (char > 64 && char < 91) || (char > 96 && char < 123) {
                    flag = true
                    break;
                }
            }
            if(flag || ageText.text!.characters.count==0 || (!flag && (Int(ageText.text!)! < 0 || Int(ageText.text!)! > 150))){
                let alert = UIAlertController(title: "Invalid age", message: "Please input a valid age.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                myInfo.age = ageText.text!
                ageText.resignFirstResponder()
                let alert = UIAlertController(title: "Saved", message: "Modification has been saved.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else if(selectItem == "Region"){
            if(regionText.text!.characters.count>30){
                let alert = UIAlertController(title: "Character limits", message: "The maximum length is 20.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                myInfo.region = regionText.text!
                regionText.resignFirstResponder()
                let alert = UIAlertController(title: "Saved", message: "Modification has been saved.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else if(selectItem == "Phone"){
            if(phoneText.text!.characters.count != 10){
                let alert = UIAlertController(title: "Wrong Phone Number", message: "The phone number should be 10 digits", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                myInfo.phone = phoneText.text!
                phoneText.resignFirstResponder()
                let alert = UIAlertController(title: "Saved", message: "Modification has been saved.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else if(self.navigationItem.title == "Motto"){
            if(mottoText.text!.characters.count>30){
                let alert = UIAlertController(title: "Character limits", message: "The maximum length is 20.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                myInfo.motto = mottoText.text!
                mottoText.resignFirstResponder()
                let alert = UIAlertController(title: "Saved", message: "Modification has been saved.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        //update to parse
        pushtoparse()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(temp.characters.count == 0){
            temp = "Male"
        }
        
        //Initialize each component deal with different selected cell
        if(selectItem == "Profile Photo"){
            imageView = UIImageView(frame: CGRectMake(self.view.frame.width*0.2, self.view.frame.height*0.2, self.view.frame.width*0.6, self.view.frame.width*0.6))
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 0
            self.view.addSubview(imageView)
            
            //button
            addButton = UIButton(type: UIButtonType.Custom)
            addButton.frame = CGRectMake(self.view.frame.width*0.2, self.view.frame.height*0.2, self.view.frame.width*0.6, self.view.frame.width*0.6)
            addButton.tag = 1
            addButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(addButton)
            imageView.image = UIImage(data: myInfo.photo!)
            imageView.highlighted = false
            
            genderPick.hidden = true;
        }
        else if(selectItem == "Name"){
            nameText = UITextField(frame: CGRectMake(5, 70, self.view.frame.width - 10, 40))
            nameText.layer.borderWidth = 0
            nameText.delegate = self
            nameText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            nameText.textAlignment = .Center
            nameText.clearButtonMode = UITextFieldViewMode.Always
            nameText.returnKeyType = UIReturnKeyType.Done
            nameText.placeholder = "Limited in 30 characters."
            nameText.text = myInfo.nickname
            self.view.addSubview(nameText)
            
            nameText.becomeFirstResponder()
            genderPick.hidden = true;
        }
        else if(selectItem == "Gender"){
            genderPick.frame = CGRectMake(10, 5, 300, 200)
            //myInfo.gender = temp
            var index = 0
            if(myInfo.gender == "Female"){
                index = 1
            }
            else if(myInfo.gender == "Not Specified"){
                index = 2
            }
            genderPick.selectRow(index,inComponent:0,animated:true)
        }
        else if(selectItem == "Region"){
            regionText = UITextField(frame: CGRectMake(5, 70, self.view.frame.width - 10, 40))
            regionText.layer.borderWidth = 0
            regionText.delegate = self
            regionText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            regionText.textAlignment = .Center
            regionText.clearButtonMode = UITextFieldViewMode.Always
            regionText.returnKeyType = UIReturnKeyType.Done
            regionText.placeholder = "Limited in 30 characters."
            regionText.text = myInfo.region
            self.view.addSubview(regionText)
            
            regionText.becomeFirstResponder()
            genderPick.hidden = true;
        }
        else if(selectItem == "Age"){
            ageText = UITextField(frame: CGRectMake(5, 70, self.view.frame.width - 10, 40))
            ageText.layer.borderWidth = 0
            ageText.delegate = self
            ageText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            ageText.textAlignment = .Center
            ageText.clearButtonMode = UITextFieldViewMode.Always
            ageText.returnKeyType = UIReturnKeyType.Done
            ageText.placeholder = "Please input a valid age."
            ageText.text = myInfo.age
            self.view.addSubview(ageText)
            
            ageText.becomeFirstResponder()
            genderPick.hidden = true;
        }
        else if(selectItem == "Phone"){
            phoneText = UITextField(frame: CGRectMake(5, 70, self.view.frame.width - 10, 40))
            phoneText.layer.borderWidth = 0
            phoneText.delegate = self
            phoneText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            phoneText.textAlignment = .Center
            phoneText.clearButtonMode = UITextFieldViewMode.Always
            phoneText.returnKeyType = UIReturnKeyType.Done
            phoneText.placeholder = "Limited in 30 characters."
            phoneText.text = myInfo.phone
            self.view.addSubview(phoneText)
            
            phoneText.becomeFirstResponder()
            genderPick.hidden = true;
        }
        else if(self.navigationItem.title == "Motto"){
            mottoText = UITextField(frame: CGRectMake(5, 70, self.view.frame.width - 10, 40))
            mottoText.layer.borderWidth = 0
            mottoText.delegate = self
            mottoText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            mottoText.textAlignment = .Center
            mottoText.clearButtonMode = UITextFieldViewMode.Always
            mottoText.returnKeyType = UIReturnKeyType.Done
            mottoText.placeholder = "Limited in 30 characters."
            mottoText.text = myInfo.motto
            self.view.addSubview(mottoText)
            
            mottoText.becomeFirstResponder()
            genderPick.hidden = true;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonAction(sender: UIButton){
        if sender.tag == 1{
            let optionMenu = UIAlertController(title: nil, message: "Please Choose an option", preferredStyle: .ActionSheet)
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
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler:{
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
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return genderChoose.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return genderChoose[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            if(row == 0){
                temp = "Male"
            }
            else if(row == 1){
                temp = "Female"
            }
            else{
                temp = "Not Specified"
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView,rowHeightForComponent component: Int) -> CGFloat{
        return 30
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView{
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        if(row == 0){
            pickerLabel.text = "Male"
        }
        else if(row == 1){
            pickerLabel.text = "Female"
            
        }
        else{
            pickerLabel.text = "Not Specified"
        }
        pickerLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16) 
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text
            else {return true}
        let newlength = text.characters.count + string.characters.count - range.length
        return newlength <= 30
    }
    
    func pushtoparse(){
        let query = PFQuery(className:"UserInfo")
        query.whereKey("ID", equalTo:myInfo.ID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                for object in objects! {
                    object["nickname"] = myInfo.nickname
                    object["gender"] = myInfo.gender
                    object["motto"] = myInfo.motto
                    object["region"] = myInfo.region
                    object["age"] = myInfo.age
                    object["phone"] = myInfo.phone
                    object["photo"] = PFFile(name:"image.jpg", data:myInfo.photo)
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
}

