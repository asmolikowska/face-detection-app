//
//  Strings.swift
//  FaceDetection
//
//  Created by Alicja Smolikowska on 21/01/2021.
//

import Foundation

class Strings {
    
    static let urls = [
        "https://static.billboard.com/files/media/Def-Leppard-1987-bw-portrait-billboard-fea-1500-compressed.jpg",
        "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F6%2F2016%2F09%2Fgettyimages-97582040.jpg",
        "https://i.iplsc.com/-/0003WRLUJQ37SEJM-C125-F4.jpg",
        "https://dynamicmedia.livenationinternational.com/Media/v/a/f/71ef4e7d-9756-4b5f-b54f-9bcf701fd81c.jpg",
        "https://i2.wp.com/niestatystyczny.pl/wp-content/uploads/2019/07/metallica.jpg?resize=1080%2C608&ssl=1",
        "https://bi.im-g.pl/im/6b/cc/18/z26004331ICR,Abba.jpg",
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
