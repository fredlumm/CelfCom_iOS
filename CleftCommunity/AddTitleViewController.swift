//
//  AddTitleViewController.swift
//  CleftCommunity
//  The view that let user to enter title of a new post.
//  Created by ShuaiFu on 15/11/26.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit

class AddTitleViewController: UIViewController, UITextFieldDelegate {
    var newTitle: UITextField!
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize each component
        newTitle = UITextField(frame: CGRectMake(5, 70, self.view.frame.width - 10, 40))
        newTitle.layer.borderWidth = 0
        newTitle.delegate = self
        newTitle.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        newTitle.clearButtonMode = UITextFieldViewMode.Always
        newTitle.returnKeyType = UIReturnKeyType.Done
        newTitle.placeholder = "Limited in 30 characters."
        self.view.addSubview(newTitle)
    }

    override func viewDidAppear(animated:Bool) {
        super.viewDidAppear(animated)
        newTitle.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        myPost.title = newTitle.text!
        newTitle.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set length limit of the textField
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text
            else {return true}
        let newlength = text.characters.count + string.characters.count - range.length
        return newlength <= 30
    }

    //MARK: - Navigation
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "aftertitle" {
            // Check title not to be empty
            if(newTitle.text?.characters.count == 0){
                let alert = UIAlertController(title: "Invalid Format", message: "The title can't be empty.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
                return false
            }
            else {
                return true
            }
        }
        else {
            return true
        }
    }
}
