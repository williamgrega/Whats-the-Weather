
//  ViewController.swift
//  Whats the Weather
//
//  Created by William Grega on 5/28/15.
//  Copyright (c) 2015 William Grega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var weather = ""
    
    @IBOutlet weak var userCity: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + userCity.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        
        if url != nil{
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
                (data, response, error)  -> Void in
                
                var urlError = false
                
                if error == nil{
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    //println(urlContent)
                    
                    var urlContentArray = urlContent?.componentsSeparatedByString("<span class=\"read-more-content\"> <span class=\"phrase\">") as NSArray!
                    
                    // </span></span></span></p><div class="forecast-cont">
                    
                    var weatherArray = urlContentArray[1].componentsSeparatedByString("</span></span></span></p><div class=\"forecast-cont\">") as NSArray!
                    
                    self.weather = weatherArray[0] as! String
                    self.weather = self.weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                }
                    
                else{
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()){
                
                if urlError == true{
                    self.showError()
                }
                else{
                    self.resultLabel.text = self.weather
                }
                } // end async
                
            })
            
            
            task.resume()
            
        }
    }
    
    func showError() {
            resultLabel.text = "Was not able to find weather for + userCity.text"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

