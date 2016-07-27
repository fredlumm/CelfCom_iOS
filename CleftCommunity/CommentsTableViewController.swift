//
//  CommentsTableViewController.swift
//  CleftCommunity
//  Table view that shows all the comments of a discussion thread.
//  Created by ShuaiFu on 15/11/21.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

class CommentsTableViewController: UITableViewController {
    
    var currentComments = [Comment]()
    var currentTID:String!
    var searchuser: UserInfo = UserInfo()
    
    // MARK: - Upload new comment
    @IBAction func unwinddonetoComments(segue: UIStoryboardSegue) {
        let addCommentVC = segue.sourceViewController as! AddCommentsViewController
        let temp = Comment()
        temp.ID = myInfo.ID
        temp.tID = self.currentTID
        temp.name = myInfo.nickname
        temp.text = addCommentVC.newComment.text
        temp.photo = myInfo.photo
        currentComments.append(temp)
        
        // save to the cloud
        let newCom = PFObject(className:"Comment")
        newCom["userID"] = myInfo.ID
        newCom["tID"] = self.currentTID
        newCom["likeNum"] = 0
        newCom["userName"] = myInfo.nickname
        newCom["content"] = addCommentVC.newComment.text
        newCom["photo"] = PFFile(name:"image.jpg", data:myInfo.photo)
        newCom.saveInBackground()
        
        // save new comment num to the specific thread
        let query = PFQuery(className:"Post")
        query.whereKey("tID", equalTo:self.currentTID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                
                for object in objects! {
                    object["comNum"] = self.currentComments.count
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        loadCom()
    }
    
    func loadCom(){
        currentComments.removeAll()
        let query = PFQuery(className:"Comment")
        query.whereKey("tID", equalTo:self.currentTID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for object in objects! {
                    let temp = Comment()
                    temp.tID = object["tID"] as! String
                    temp.text = object["content"] as! String
                    temp.ID = object["userID"] as! String
                    temp.likeNum = object["likeNum"] as! Int
                    temp.name = object["userName"] as! String
                    let userImageFile = object["photo"] as! PFFile
                    temp.OID = object.objectId!
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            temp.photo = imageData
                            self.tableView.reloadData()
                        }
                        else{
                            print("Error: \(error!)")
                        }
                    }
                    self.currentComments.append(temp)
                    
                }
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.currentComments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentsCell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        // Configure the cell...
        // Design the sturcture of new cell
        if cell.viewWithTag(1) == nil {
            let iv = UIImageView()
            iv.tag = 1
            cell.contentView.addSubview(iv)
            let name = UIButton()
            name.tag = 2
            cell.contentView.addSubview(name)
            let text = UITextView()
            text.tag = 3
            cell.contentView.addSubview(text)
            let likelab = UIButton()
            likelab.tag = 4
            cell.contentView.addSubview(likelab)
            let number = UILabel()
            number.tag = 5
            cell.contentView.addSubview(number)
            let oid = UILabel()
            oid.tag = 6
            cell.contentView.addSubview(oid)
            
            iv.frame = CGRectMake(20, 10, cell.contentView.frame.width*0.1, cell.contentView.frame.width*0.1)
            iv.layer.cornerRadius = cell.contentView.frame.width*0.05
            iv.layer.masksToBounds = true
            iv.layer.borderWidth = 0
            name.frame = CGRectMake(30 + cell.contentView.frame.width*0.1, 5, cell.contentView.frame.width*0.6 - 30, cell.contentView.frame.height*0.3)
            name.titleLabel?.font = UIFont(name:"HelveticaNeue-Medium", size: 14.0)
            name.setTitleColor(UIColor.blackColor(), forState: .Normal)
            name.contentHorizontalAlignment = .Left
            name.addTarget(self, action: "toPro:", forControlEvents: .TouchUpInside)
            name.titleLabel?.adjustsFontSizeToFitWidth = true
            name.titleLabel?.minimumScaleFactor = 0.5
            likelab.frame = CGRectMake(cell.contentView.frame.width*0.8, 10, cell.contentView.frame.width*0.1, cell.contentView.frame.height*0.3)
            likelab.setTitle("what", forState: .Normal)
            likelab.titleLabel?.font = UIFont(name:"HelveticaNeue-Medium", size: 14.0)
            likelab.setTitleColor(UIColor.blackColor(), forState: .Normal)
            likelab.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
            likelab.setImage(UIImage(named: "thumb.jpg"), forState: .Normal)
            likelab.imageView?.contentMode = .ScaleAspectFit
            number.frame = CGRectMake(cell.contentView.frame.width*0.9, 10, cell.contentView.frame.width*0.1, cell.contentView.frame.height*0.3)
            number.font = UIFont(name:"HelveticaNeue-Medium", size: 14.0)
            text.frame = CGRectMake(20, cell.contentView.frame.width*0.1 + 20, cell.contentView.frame.width - 30, cell.contentView.frame.height*0.7 - 20)
            text.font = UIFont(name:"HelveticaNeue-Light", size: 14.0)
            text.editable = false
            oid.frame = CGRectMake(0,0,1,1)
            oid.hidden = true
        }
        
        // Assign value for each cell
        let iv = cell.viewWithTag(1) as! UIImageView
        iv.image = UIImage(data: currentComments[indexPath.row].photo)
        let name = cell.viewWithTag(2) as! UIButton
        name.setTitle(currentComments[indexPath.row].name + " (ID: " + currentComments[indexPath.row].ID + ")", forState: .Normal)
        let text = cell.viewWithTag(3) as! UITextView
        text.text = currentComments[indexPath.row].text
        let number = cell.viewWithTag(5) as! UILabel
        number.text = "\(currentComments[indexPath.row].likeNum)"
        let oid = cell.viewWithTag(6) as! UILabel
        oid.text = currentComments[indexPath.row].OID
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.frame.width*0.3
    }
    
    // Show comment author's profile
    func toPro(sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath: NSIndexPath = self.tableView.indexPathForCell(cell)!
        let destination = self.storyboard?.instantiateViewControllerWithIdentifier("ProView") as! ComProfileTableViewController
        let query = PFQuery(className:"UserInfo")
        query.whereKey("ID", equalTo: currentComments[indexPath.row].ID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                let objects = objects! 
                if(objects.count == 0){}
                else{
                    for object in objects {
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
                            destination.friend.nickname = self.searchuser.nickname
                            destination.friend.gender = self.searchuser.gender
                            destination.friend.region = self.searchuser.region
                            destination.friend.age = self.searchuser.age
                            destination.friend.ID = self.searchuser.ID
                            destination.friend.email = self.searchuser.email
                            destination.friend.phone = self.searchuser.phone
                            destination.friend.motto = self.searchuser.motto
                            destination.friend.photo = self.searchuser.photo
                            self.showViewController(destination, sender: self)
                        }
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    // Update like number
    func buttonAction(sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let number = cell.viewWithTag(5) as! UILabel
        let oid = cell.viewWithTag(6) as! UILabel
        let temp = Int(number.text!)
        
        // Check whether the user have liked that comment
        for i in likeComments {
            if (i == oid.text!) {
                let alert = UIAlertController(title: "Already liked", message: "You can only like a comment once.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
        }
        likeComments.append(oid.text!)
        
        // Showed number plus one
        number.text = "\(temp!+1)"
        
        // Upload that a new like has been added
        var query = PFQuery(className:"Comment")
        query.whereKey("objectId", equalTo: oid.text!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                for object in objects! {
                    object["likeNum"] = Int(number.text!)
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        // Upload that the user has liked that comment
        query = PFQuery(className:"UserInfo")
        query.whereKey("ID", equalTo: myInfo.ID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                for object in objects! {
                    object["likeComments"] = likeComments
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "addComments"){
            
            let addCommentVC = segue.destinationViewController as! AddCommentsViewController
            addCommentVC.currentTID = self.currentTID
        }
    }
}
