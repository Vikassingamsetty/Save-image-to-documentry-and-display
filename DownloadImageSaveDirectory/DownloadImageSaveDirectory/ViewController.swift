//
//  ViewController.swift
//  DownloadImageSaveDirectory
//
//  Created by Srans022019 on 14/05/20.
//  Copyright © 2020 vikas. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documentsPath.count > 0 {
            
            let documentDirectory = documentsPath[0]
            
            let restorePath = documentDirectory + "/image.jpg"
            
            imageView.image = UIImage(contentsOfFile: restorePath)
        
        }
        
        //MARK:- saving data by func call and comment it to see the saved image once app is build.
        
       // imageURLSaveToDirectory()
        
        // Do any additional setup after loading the view.
    }
    
    func imageURLSaveToDirectory() {
        
        let url = URL(string: "https://image.shutterstock.com/image-photo/bright-spring-view-cameo-island-260nw-1048185397.jpg")
        
        AF.request(url!).validate().responseJSON { (response) in
            
            let responses = response.data
            
            if responses!.count > 0 {
                
                if let responseImage = responses {
                    
                    let imageConversion = UIImage(data: responseImage)
                    
                    self.imageView.image = imageConversion
                    
                    // Saving image to document directory
                    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                    
                    if documentsPath.count > 0 {
                        
                         let documentDirectory = documentsPath[0]
                            
                            let savePath = documentDirectory + "/image.jpg"
                            
                            do{
                                if let data = imageConversion!.jpegData(compressionQuality: 1.0) {
                                    
                                    try data.write(to: URL(fileURLWithPath: savePath))
                                }
                               
                            }catch{
                                print(error)
                            }
                        
                    }
                    
                }
                
            }
            
        }
    }
    
}

