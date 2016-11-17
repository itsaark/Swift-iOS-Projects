//
//  ViewController.swift
//  Parrot
//
//  Created by Arjun Kodur on 11/17/16.
//  Copyright © 2016 Arjun Kodur. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import AlamofireImage
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //IBM Watson Key
    let apiKey = "YOUR KEY"
    let version = "2016-11-17"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageTitle.text = "Tap the camera button"
    }

    
    @IBAction func getImage(_ sender: Any) {
        
        let button = sender as! UIBarButtonItem
        button.isEnabled = false
        
        let randomNumber = Int(arc4random_uniform(1500))
        let urlString = "https://unsplash.it/400/700?image=\(randomNumber)"

        Alamofire.request(urlString).responseImage { response in
            
            if let image = response.result.value {
                
                DispatchQueue.main.async {
                    
                    self.imageView.image = image
                }
            }
        }
        
        let imageUrlIMB = URL(string: "https://unsplash.it/50/100?image=\(randomNumber)")!
        
        let failure = {(error:Error) in
            
            DispatchQueue.main.async {
                self.imageTitle.text = "Image could not be processed"
                button.isEnabled = true
            }
            
            print(error)
        }
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        visualRecognition.classify(image: imageUrlIMB.absoluteString , failure: failure) { classifiedImages in
            
            if let classifiedImage = classifiedImages.images.first {
                
                if let classification = classifiedImage.classifiers.first?.classes.first?.classification{
                    
                    DispatchQueue.main.async {
                        
                        self.imageTitle.text = classification
                        button.isEnabled = true
                    }
                }else{
                    
                    DispatchQueue.main.async {
                        self.imageTitle.text = "Image cannot be classified"
                        button.isEnabled = true
                    }
                }
            }else{
                
                DispatchQueue.main.async {
                    
                    self.imageTitle.text = "Image cannot be classified"
                    button.isEnabled = true
                }
            }
        }
        
        
    }


}

