//
//  ContentView.swift
//  ImagePickerPoc
//
//  Created by Bharat on 10/04/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State var actionSheet = false
    @State var imagePIc = false
    @State var imageSource = UIImagePickerController.SourceType.photoLibrary
    @State var alert = false
    @State var alertMessage = ""
    @State var image:UIImage = UIImage(named: "Dummy")!
    
    var body: some View {
        
        VStack{
            Spacer()
            Image(uiImage: image)
            .resizable()
            .frame(width:100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
            .shadow(radius: 5)
            Spacer()
            
            addButton()
                .actionSheet(isPresented: $actionSheet) {
                    createActionSheet()
            }
            .sheet(isPresented: $imagePIc) {
                ImagePicker(sourceType: self.imageSource) { (returnedImage) in
                    if returnedImage != nil{
                        self.image = returnedImage!
                    }
                }
            }
            
            .alert(isPresented: self.$alert) {
                Alert.init(title: Text(self.alertMessage))
            }
        }
    }
    
    func createActionSheet() -> ActionSheet {
        let lib = ActionSheet.Button.default(Text("Library")){
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                self.imageSource = .photoLibrary
                self.imagePIc.toggle()
            }else{
                self.alertMessage = "photo library not available"
                self.alert.toggle()
            }
            
        }
        
        let camera = ActionSheet.Button.default(Text("Camera")){
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imageSource = .camera
                self.imagePIc.toggle()
            }else{
                self.alertMessage = "Camera not availabele"
                self.alert.toggle()
            }
           
        }
        
        let cancel = ActionSheet.Button.cancel()
        
        return ActionSheet.init(title: Text("select Image"), message: Text("Select Image Source"), buttons: [lib,camera,cancel])
    }
    
    func addButton() -> some View {
        return Button(action: {
            self.actionSheet.toggle()
        }){
            Text("Pick Image")
                .font(.title)
        }.frame(width: UIScreen.main.bounds.width, height: 60)
            .background(Color.blue)
            .foregroundColor(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
