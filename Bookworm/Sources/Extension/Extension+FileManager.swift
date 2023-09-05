//
//  Extension+FileManager.swift
//  Bookworm
//
//  Created by 박소진 on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
}
