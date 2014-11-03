//
//  ViewController.swift
//  WebContent
//
//  Created by Bob on 06/10/2014.
//  Copyright (c) 2014 BallisticSoft. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    
    @IBOutlet var inputText: UITextField!
    @IBOutlet var weatherLable: UILabel!
    @IBAction func button(sender: AnyObject) {
        
        var urlString = "http://www.weather-forecast.com/locations/" + inputText.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        
        
        var url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)  {(data, response, error) in
            
        var urlOutput = NSString(data: data, encoding: NSUTF8StringEncoding)
            if urlOutput?.containsString("<span class=\"phrase\">") == true {
        var contentArray = urlOutput?.componentsSeparatedByString("<span class=\"phrase\">")
        var newContentArray = contentArray?[1].componentsSeparatedByString("</span>")
        var messageFixed = newContentArray?[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
        
            

            println(messageFixed)
            dispatch_async(dispatch_get_main_queue()){

            self.weatherLable.text = (messageFixed! as String)

            }
         

            } else {
                println("try again")
                dispatch_async(dispatch_get_main_queue()) {
                self.weatherLable.text = "I Can't Find That City. Try Again Please."
            
                }
                }
                
        }
        inputText.resignFirstResponder()
        task.resume()
        
   
      
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
      

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

