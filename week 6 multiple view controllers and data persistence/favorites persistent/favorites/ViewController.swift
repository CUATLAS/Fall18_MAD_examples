//
//  ViewController.swift
//  favorites
//
//  Created by Aileen Pierce
//  Copyright (c) Aileen Pierce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var user=Favorite()
    
    let filename = "test.plist"
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        bookLabel.text=user.favBook
        authorLabel.text=user.favAuthor
    }
    
/*
 file path as a String
    func docFilePath(_ filename: String) -> String?{
        //locate the documents directory
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString //document directory
        //creates the full path to our data file
        print(dir.appendingPathComponent(filename))
        return dir.appendingPathComponent(filename)
    }

*/
 
    func dataFileURL(_ filename:String) -> URL? {
        //returns an array of URLs for the document directory in the user's home directory
        let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        var url : URL?
        //append the file name to the first item in the array which is the document directory
        url = urls.first?.appendingPathComponent(filename)
        //return the URL of the data file or nil if it does not exist
        return url
    }
 
    override func viewDidLoad() {
        //url of data file
        let fileURL = dataFileURL(filename)
        
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: (fileURL?.path)!){
            let url = fileURL!
            do {
                //creates a data buffer with the contents of the plist
                let data = try Data(contentsOf: url)
                //create an instance of PropertyListDecoder
                let decoder = PropertyListDecoder()
                //decode the data using the structure of the Favorite class
                user = try decoder.decode(Favorite.self, from: data)
                //assign data to textfields
                bookLabel.text=user.favBook
                authorLabel.text=user.favAuthor
            } catch {
                print("no file")
            }
            
            /*pre swift 4
            //uses String instead or URL
            //load the data of the plist file into a dictionary
            let dataDictionary = NSDictionary(contentsOfFile: path!) as! [String:String]
            //load favorite book
            if dataDictionary.keys.contains("favBook") {
                user.favBook = dataDictionary["favBook"]
                bookLabel.text=user.favBook
            }
            //load favorite author
            if dataDictionary.keys.contains("favAuthor") {
                user.favAuthor = dataDictionary["favAuthor"]
                authorLabel.text=user.favAuthor
            }
             */
            
        }
        else {
            print("file does not exist")
        }
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(_:)), name: Notification.Name.UIApplicationWillResignActive, object: app)

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //called when the UIApplicationWillResignActiveNotification notification is posted
    //all notification methods take a single NSNotification instance as their argument
    @objc func applicationWillResignActive(_ notification: Notification){
        //url of data file
        let fileURL = dataFileURL(filename)
        //create an instance of PropertyListEncoder
        let encoder = PropertyListEncoder()
        //set format type to xml
        encoder.outputFormat = .xml
        do {
            //encode the data using the structure of the Favorite class
            let plistData = try encoder.encode(user)
            //write encoded data to the file
            try plistData.write(to: fileURL!)
        } catch {
            print("write error")
        }

        /* pre swift 4
        let data = NSMutableDictionary()
        //adds
        if user.favBook != nil{
            data.setValue(user.favBook, forKey: "favBook")
            
        }
        if user.favAuthor != nil{
            data.setValue(user.favAuthor, forKey: "favAuthor")
        }
        //write the contents of the array to our plist file
        //data.write(toFile: filePath!, atomically: true)
 
         */
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

