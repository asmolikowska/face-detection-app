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
        print(facesCount)
        return facesCount
    }
}

