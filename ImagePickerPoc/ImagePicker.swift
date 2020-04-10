//
//  ImagePicker.swift
//  ImagePickerPoc
//
//  Created by Bharat on 10/04/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker:UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    let sourceType:UIImagePickerController.SourceType
    
    var pickedImage:((UIImage?)->())?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imageVC = UIImagePickerController()
        imageVC.sourceType = sourceType
        imageVC.delegate = context.coordinator
        imageVC.allowsEditing = false
        return imageVC
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        
        let parent:ImagePicker!
        
        init(_ parent:ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as? UIImage
            parent.pickedImage?(image)
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
