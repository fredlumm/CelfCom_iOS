//
//  LoginParseViewController.swift
//  CleftCommunity
//
//  Created by 陆明明 on 11/14/15.
//  Copyright © 2015 ShuaiFu. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LoginParseViewController: PFLogInViewController {
    
    var cnt:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Cleft Community"
        self.navigationController?.navigationBarHidden = true
        let signUpVC = PFSignUpViewController()
        signUpVC.delegate = self
        self.delegate = self
        self.signUpController = signUpVC
        
        // configure the login View
        self.view.backgroundColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)
        //100，149，237
        
        // configure the log
        logInView?.logo = UIImageView(image:UIImage(named: "logo"))
        logInView?.logo?.contentMode = .ScaleAspectFit
        
        signUpVC.signUpView?.logo = UIImageView(image:UIImage(named: "logo"))
        signUpVC.signUpView?.logo?.contentMode = .ScaleAspectFit
        signUpVC.view.backgroundColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)
        
    }
    
    func showInBox(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}




extension LoginParseViewController: PFSignUpViewControllerDelegate{
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil);
        
        //print("after save and update the count, The count is " + "\(cnt)")
        
        user["ID"] = "\(self.cnt)"
        user.saveInBackground()
        
        //create a new UserInfo
        let newuser = PFObject(className:"UserInfo")
        newuser["nickname"] = user.username!
        newuser["ID"] = user["ID"]
        newuser["gender"] = ""
        newuser["region"] = ""
        newuser["email"] = user.email!
        newuser["phone"] = ""
        newuser["motto"] = ""
        newuser["age"] = ""
        let newimage = UIImage(named:"initial.jpg")
        let imageData = UIImageJPEGRepresentation(newimage!, 1.0)
        newuser["photo"] = PFFile(name:"image.jpg", data:imageData!)
        newuser["friends"] = [String]()
        newuser["likeComments"] = [String]()
        newuser.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("saved")
            } else {
                // There was a problem, check error.description
                print("error")
            }
        }
        
        //set up local myinfo
        myInfo.nickname = user.username!
        myInfo.ID = user["ID"] as! String
        myInfo.gender = ""
        myInfo.region = ""
        myInfo.email = user.email!
        myInfo.phone = ""
        myInfo.motto = ""
        myInfo.photo = imageData
        
        showInBox()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        // figure the cnt
        let query = PFQuery(className:"UserNum")
        query.whereKey("objectId", equalTo:"6MAiXlj9T3")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                //print("Get the useNum and update it ")
                for object in objects! {
                    self.cnt = object["Num"] as! Int
                    self.cnt++
                    //print("The count is " + "\(self.cnt)")
                    
                    object["Num"] = self.cnt
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        return true
    }
    
}


func getmyinfo(id: String){
    let query = PFQuery(className:"UserInfo")
    query.whereKey("ID", equalTo:id)
    query.findObjectsInBackgroundWithBlock {
        (objects: [PFObject]?, error: NSError?) -> Void in
        if error == nil {
            // Do something with the found objects
            let objects = objects! 
            for object in objects {
                myInfo.nickname = object["nickname"] as! String
                myInfo.ID = object["ID"] as! String
                myInfo.email = object["email"] as! String
                myInfo.gender = object["gender"] as! String
                myInfo.motto = object["motto"] as! String
                myInfo.phone = object["phone"] as! String
                myInfo.region = object["region"] as! String
                let userImageFile = object["photo"] as! PFFile
                userImageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        myInfo.photo = imageData
                    }
                }
            }
        } else {
            // Log details of the failure
            print("Error: \(error!) \(error!.userInfo)")
        }
    }
}

func getmyfriendsinfo(id: String){
    friends.removeAll()
    let query = PFQuery(className:"UserInfo")
    query.whereKey("ID", equalTo:id)
    query.findObjectsInBackgroundWithBlock {
        (objects: [PFObject]?, error: NSError?) -> Void in
        if error == nil {
            // Do something with the found objects
            for object in objects! {
                var arr = object["friends"] as! Array<String>
                for(var i=0; i<arr.count; i++){
                    let newquery = PFQuery(className:"UserInfo")
                    newquery.whereKey("ID", equalTo:arr[i])
                    newquery.findObjectsInBackgroundWithBlock {
                        (newobjects: [PFObject]?, error: NSError?) -> Void in
                        if error == nil {
                            // Do something with the found objects
                            for user in newobjects! {
                                let temp = UserInfo()
                                temp.nickname = user["nickname"] as! String
                                temp.ID = user["ID"] as! String
                                temp.email = user["email"] as! String
                                temp.gender = user["gender"] as! String
                                temp.motto = user["motto"] as! String
                                temp.phone = user["phone"] as! String
                                temp.region = user["region"] as! String
                                let userImageFile = user["photo"] as! PFFile
                                userImageFile.getDataInBackgroundWithBlock {
                                    (imageData: NSData?, error: NSError?) -> Void in
                                    if error == nil {
                                        temp.photo = imageData
                                    }
                                }
                                friends.append(temp)
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                        
                    }
                }
            }
        } else {
            // Log details of the failure
            print("Error: \(error!) \(error!.userInfo)")
        }
    }
}

extension LoginParseViewController:PFLogInViewControllerDelegate{
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        showInBox()
        //getmyinfo(user["ID"] as! String)
        //getmyfriendsinfo(user["ID"] as! String)
    }
}
