//
//  ViewController.swift
//  FaceDetection
//
//  Created by Alicja Smolikowska on 19/01/2021.
//

import UIKit
import SwiftSpinner
import CoreImage
import ReactiveKit
import Bond

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    let downloadDidFinish = false
    var numberOfFaces = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func `import`(_ sender: Any) {
        let stringUrl = Strings.pickRandomUrlString()
        let downloadUrl: URL = URL(string: stringUrl)!
        SwiftSpinner.show("Downloading Image")
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
            self.viewModel.downloadDidFinish.value = true
            SwiftSpinner.hide()
        }.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _ = self.viewModel.downloadDidFinish.observeNext(with: { [unowned self] _ in
            self.performDetection()
        }).dispose(in: disposeBag)
    }
    
    func performDetection() {
        DispatchQueue.main.async {
            guard let image = self.imageView.image else { return }
            guard let imageCi = CIImage(image: image) else { return }
            self.numberOfFaces = self.viewModel.detectFaces(img: imageCi)
        }
    }
}

