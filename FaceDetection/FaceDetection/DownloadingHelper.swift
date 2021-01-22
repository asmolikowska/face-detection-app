
import Foundation
import ReactiveKit
import Bond

class DownloadingHelper {
    let downloadFinished = Observable<Bool>(false)
    
    func getDocumentsDirectory() -> URL {
        let PathsDocument = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return PathsDocument[0]
    }
    
    func writeImgInDocuments(image: UIImage, name: String) {
        let urlDocuments = self.getDocumentsDirectory().appendingPathComponent(name)
        do {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: urlDocuments)
            }
        } catch {
            print(error)
        }
    }
}

