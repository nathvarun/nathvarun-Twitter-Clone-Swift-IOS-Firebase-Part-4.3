//
//  NewTweetViewController.swift
//  Twitter Clone
//
//  Created by Varun Nath on 25/08/16.
//  Copyright © 2016 UnsureProgrammer. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewTweetViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var newTweetTextView: UITextView!
    
    //create a reference to the database
    var databaseRef = FIRDatabase.database().reference()
    var loggedInUser = AnyObject?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loggedInUser = FIRAuth.auth()?.currentUser
        
        newTweetTextView.textContainerInset = UIEdgeInsetsMake(30, 20, 20, 20)
        newTweetTextView.text = "What's Happening?"
        newTweetTextView.textColor = UIColor.lightGrayColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapCancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true
            , completion: nil)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if(newTweetTextView.textColor == UIColor.lightGrayColor())
        {
            newTweetTextView.text = ""
            newTweetTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }

    @IBAction func didTapTweet(sender: AnyObject) {
        
        if(newTweetTextView.text.characters.count>0)
        {
            let key = self.databaseRef.child("tweets").childByAutoId().key
            
            let childUpdates = ["/tweets/\(self.loggedInUser!.uid)/\(key)/text":newTweetTextView.text,
                                "/tweets/\(self.loggedInUser!.uid)/\(key)/timestamp":"\(NSDate().timeIntervalSince1970)"]
            
            self.databaseRef.updateChildValues(childUpdates)
            
            dismissViewControllerAnimated(true, completion: nil)

        }
    }
 
    
    

}
