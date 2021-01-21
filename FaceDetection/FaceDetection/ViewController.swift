//
//  ViewController.swift
//  FaceDetection
//
//  Created by Alicja Smolikowska on 19/01/2021.
//

import UIKit

class ViewController: UIViewController {
//    var stringUrl = Strings.pickRandomUrlString()
//    lazy var downloadUrl: URL = URL(string: stringUrl)!
//    var reset = false
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBAction func `import`(_ sender: Any) {
        let stringUrl = Strings.pickRandomUrlString()
        let downloadUrl: URL = URL(string: stringUrl)!
        self.button.isEnabled = false
        
        URLSession.shared.dataTask(with: downloadUrl) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("something went wrong here")
            }
            
            switch httpResponse.statusCode {
            case 200:
                guard let imageData = data else {
                    fatalError("not image data")
                }
                
                guard let image = UIImage.init(data: imageData) else {
                    fatalError("not valid image data")
                }
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.button.isEnabled = true
                }
                
            default:
                fatalError("not 200 response provided")
            }
            
        }.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

