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
import SwiftyBeaver

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    let downloadDidFinish = false
    var numberOfFaces = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func `import`(_ sender: Any) {
        SwiftyBeaver.verbose("Save button clicked")
        let stringUrl = Strings.pickRandomUrlString()
        let downloadUrl: URL = URL(string: stringUrl)!
        SwiftSpinner.show("Downloading Image")
        self.button.isEnabled = false
        
        URLSession.shared.dataTask(with: downloadUrl) { (data, response, error) in
            SwiftyBeaver.info("Started downloading image with URLSession")
            
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
                
                SwiftyBeaver.info("Uploading image to document directory started")
                self.viewModel.writeImgInDocuments(image: image, name: "image.jpg")
                SwiftyBeaver.info("Uploading image to document directory ended")
                
                DispatchQueue.main.async {
                    SwiftyBeaver.verbose("Back to the main thread to set up image view started")
                    self.imageView.image = image
                    self.button.isEnabled = true
                    SwiftyBeaver.verbose("Back to the main thread to set up image view ended")
                }
                
            default:
                fatalError("not 200 response provided")
            }
            self.viewModel.downloadDidFinish.value = true
            SwiftSpinner.hide()
        }.resume()
        SwiftyBeaver.info("End of URLSession with resume()")
    }
    override func viewDidLoad() {
        prepareView()
        super.viewDidLoad()
        _ = self.viewModel.downloadDidFinish.observeNext(with: { [unowned self] _ in
            SwiftyBeaver.info("Performing face detection started")
            self.performDetection()
            SwiftyBeaver.info("Performing face detection ended")
        }).dispose(in: disposeBag)
    }
    
    func performDetection() {
        SwiftyBeaver.verbose("DispatchQueue.main.async to perform detection started")
        DispatchQueue.main.async {
            guard let image = self.imageView.image else { return }
            guard let imageCi = CIImage(image: image) else { return }
            self.numberOfFaces = self.viewModel.detectFaces(img: imageCi)
            self.label.text = "The number of faces detected is " + String(self.numberOfFaces)
        }
        SwiftyBeaver.verbose("DispatchQueue.main.async to perform detection started ended")
    }
    
    func prepareView() {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
}

