//
//  AddFriendViewController.swift
//  CleftCommunity
//  The view that let the user search another user.
//  Created by ShuaiFu on 15/11/3.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

class AddFriendViewController: UIViewController {
    
    var label: UILabel!
    var text: UITextField!
    var foundlabel: UILabel!
    var searchuser: UserInfo = UserInfo()
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    @IBAction func searchInfo(sender: AnyObject) {
        self.showButton.hidden = true
        let searchID = text.text
        if(searchID!.characters.count==0){
            let alert = UIAlertController(title: "Input Empty", message: "Please input a valid ID", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                (action: UIAlertAction) -> Void in
                })
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            //perform a query
            let query = PFQuery(className:"UserInfo")
            query.whereKey("ID", equalTo:searchID!)
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    // Do something with the found objects
                    let objects = objects! 
                    if(objects.count == 0){
                        self.foundlabel.text = "The user is not found!"
                        self.foundlabel.textAlignment = .Center
                        self.foundlabel.font = UIFont(name: "Times New Roman", size: 16)
                        self.foundlabel.textColor = UIColor.redColor()
                    }
                    else{
                        for object in objects{
                            self.foundlabel.text = object["nickname"] as? String
                            self.foundlabel.textAlignment = .Center
                            self.foundlabel.font = UIFont(name: "Times New Roman", size: 16)
                            self.foundlabel.textColor = UIColor.blueColor()
                            self.showButton.hidden = false
                            self.searchuser.nickname = object["nickname"] as! String
                            self.searchuser.ID = object["ID"] as! String
                            self.searchuser.age = object["age"] as! String
                            self.searchuser.email = object["email"] as! String
                            self.searchuser.gender = object["gender"] as! String
                            self.searchuser.motto = object["motto"] as! String
                            self.searchuser.phone = object["phone"] as! String
                            self.searchuser.region = object["region"] as! String
                            let userImageFile = object["photo"] as! PFFile
                            userImageFile.getDataInBackgroundWithBlock {
                                (imageData: NSData?, error: NSError?) -> Void in
                                if error == nil {
                                    self.searchuser.photo = imageData
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
    }
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        label = UILabel()
        label.frame = CGRectMake((self.view.frame.width - 200)/2, 90, 200, 25)
        label.text = "Please enter a Community ID:"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.textAlignment = .Center
        self.view.addSubview(label)
        text = UITextField(frame: CGRectMake((self.view.frame.width - 200)/2, 140, 200, 25))
        text.borderStyle = UITextBorderStyle.RoundedRect
        text.textAlignment = .Left
        text.font = UIFont(name:"HelveticaNeue-Medium", size: 14)
        text.clearButtonMode = UITextFieldViewMode.WhileEditing
        text.returnKeyType = UIReturnKeyType.Done
        self.view.addSubview(text)
        searchButton.frame = CGRectMake(120, 160, 80, 25)
        foundlabel = UILabel()
        foundlabel.frame = CGRectMake((self.view.frame.width - 150)/2, 230, 150, 25)
        foundlabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        view.addSubview(self.foundlabel)
        showButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showsearch"{
            if let destination = segue.destinationViewController as? FriendProfileTableViewController {
                destination.friend.nickname = self.searchuser.nickname
                destination.friend.gender = self.searchuser.gender
                destination.friend.region = self.searchuser.region
                destination.friend.age = self.searchuser.age
                destination.friend.ID = self.searchuser.ID
                destination.friend.email = self.searchuser.email
                destination.friend.phone = self.searchuser.phone
                destination.friend.motto = self.searchuser.motto
                destination.friend.photo = self.searchuser.photo
            }
        }
    }
}
