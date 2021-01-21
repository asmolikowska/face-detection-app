//
//  ViewController.swift
//  FaceDetection
//
//  Created by Alicja Smolikowska on 19/01/2021.
//

import UIKit
import NVActivityIndicatorView
import CoreImage
import ReactiveKit
import Bond
import os

class ViewController: UIViewController {
    
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "app")
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    var activityIndicator : NVActivityIndicatorView!
    
    let viewModel = DownloadingHelper()
    let disposeBag = DisposeBag()
    var detectedFacesNumber: Int = 0
    
    func load() {
        let xAxis = self.view.center.x // or use (view.frame.size.width / 2) // or use (faqWebView.frame.size.width / 2)
        let yAxis = self.view.center.y // or use (view.frame.size.height / 2) // or use (faqWebView.frame.size.height / 2)
        
        
        
        let frame = CGRect(x: (xAxis - 50), y: (yAxis - 50), width: 45, height: 45)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = . ballScale // add your type
        activityIndicator.color = UIColor.red // add your color
        
        self.view.addSubview(activityIndicator) // or use  webView.addSubview(activityIndicator)
    }
    
    @IBAction func `downloadImage`(_ sender: Any) {
        logger.log("IBAction buton started")
        let stringUrl = SharedStrings.generateRandomUrlStr()
        let downloadUrl: URL = URL(string: stringUrl)!
        self.activityIndicator.startAnimating()
        self.button.isEnabled = false
        
        URLSession.shared.dataTask(with: downloadUrl) { (data, response, error) in
            self.logger.log("start URLSession.shared.dataTask")
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
                self.logger.log("start writing to document directory")
                self.viewModel.writeImgInDocuments(image: image, name: "image.jpg")
                self.logger.log("end writing to document directory")
                
                DispatchQueue.main.async {
                    self.logger.log("start setting up image view main thread")
                    self.imageView.image = image
                    self.button.isEnabled = true
                    self.logger.log("end setting up image view main thread")
                }
                
            default:
                fatalError("not 200 response provided")
            }
            self.viewModel.downloadFinished.value = true
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }.resume()
        self.logger.log("end url session")
    }
    
    func detectFacesInViewController() {
        DispatchQueue.main.async {
            guard let image = self.imageView.image else { return }
            guard let preparedImage = CIImage(image: image) else { return }
            self.detectedFacesNumber = self.countFacesDetected(img: preparedImage)
            self.label.text = "We detected " + String(self.detectedFacesNumber) + " number of faces!"
        }
    }
    
    override func viewDidLoad() {
        load()
        super.viewDidLoad()
        _ = self.viewModel.downloadFinished.observeNext(with: { [unowned self] _ in
            self.logger.log("start face detection")
            self.detectFacesInViewController()
            self.logger.log("end face detection")
        }).dispose(in: disposeBag)
    }
    
    
    func countFacesDetected(img: CIImage) -> Int {
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: img)
        guard let facesCount = faces?.count else { return 0 }
        return facesCount
    }
}

