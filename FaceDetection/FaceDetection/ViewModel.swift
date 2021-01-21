//
//  ViewModel.swift
//  FaceDetection
//
//  Created by Alicja Smolikowska on 21/01/2021.
//

import Foundation
import ReactiveKit
import Bond

class ViewModel {
    let downloadDidFinish = Observable<Bool>(false)
    
    func detectFaces(img: CIImage) -> Int {
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: img)
        guard let facesCount = faces?.count else { return 0 }
        return facesCount
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func writeImgInDocuments(image: UIImage, name: String) {
        let url = self.getDocumentsDirectory().appendingPathComponent(name)
        do {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: url)
            }
        } catch {
            print(error)
        }
    }
}

