//
//  Strings.swift
//  FaceDetection
//
//  Created by Alicja Smolikowska on 21/01/2021.
//

import Foundation

class Strings {
    
    static let urls = [
        "https://upload.wikimedia.org/wikipedia/commons/0/04/Dyck,_Anthony_van_-_Family_Portrait.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/c/c8/Valmy_Battle_painting.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/c/ce/Petrus_Christus_-_Portrait_of_a_Young_Woman_-_Google_Art_Project.jpg",
        "https://i2.wp.com/niestatystyczny.pl/wp-content/uploads/2019/07/metallica.jpg?resize=1080%2C608&ssl=1",
        "https://upload.wikimedia.org/wikipedia/commons/3/36/Quentin_Matsys_-_A_Grotesque_old_woman.jpg",
        "https://www.terazmuzyka.pl/wp-content/uploads/news/Ir/Iron%20Maiden_1468.jpg"
    ]
    
    static func pickRandomUrlString() -> String {
        let defaultPhotoUrl = ""
        if let randomElement = urls.randomElement() {
            return randomElement
        }
        return defaultPhotoUrl
    }
}
