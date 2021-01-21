//
//  Strings.swift
//  FaceDetection
//
//  Created by Alicja Smolikowska on 21/01/2021.
//

import Foundation

class Strings {
    
    static let urls = [
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Angelina_Jolie_%2848462859552%29.jpg/399px-Angelina_Jolie_%2848462859552%29.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Brad_Pitt_2019_by_Glenn_Francis.jpg/800px-Brad_Pitt_2019_by_Glenn_Francis.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Billy_Bob_Thornton_2008_%282%29.jpg/1280px-Billy_Bob_Thornton_2008_%282%29.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Charlie_Chaplin_portrait.jpg/450px-Charlie_Chaplin_portrait.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/4/46/Leonardo_Dicaprio_Cannes_2019.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/2/23/CameronDiazByCarolineRenouard2010.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/3/3b/Maryla_Rodowicz_2017.jpg"
    ]
    
    static func pickRandomUrlString() -> String {
        let defaultPhotoUrl = ""
        if let randomElement = urls.randomElement() {
            return randomElement
        }
        return defaultPhotoUrl
    }
}
