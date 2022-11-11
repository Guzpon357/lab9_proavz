//
//  TareaExamViewController.swift
//  Intagram-Tecsup-LGuzman
//
//  Created by MAC35 on 11/11/22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class TareaExamViewController: UIViewController {

    let imagePicker = UIImagePickerController()
    let db2 = Firestore.firestore()
    
    @IBOutlet weak var txttitulo: UILabel!
    @IBOutlet weak var Imagen: UIImageView!
    @IBOutlet weak var txtDes: UITextField!
    
    
    @IBAction func OnTabGallery(_ sender: UIButton) {
        imagePicker.isEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    func saveUserData(url : String){
        db2.collection("posts").addDocument(data: [
            "title":txttitulo.text!,
            "descripcion":txtDes.text!,
            "image": url,
            "usedId": Auth.auth().currentUser?.uid ?? "no-id"
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImagePicker()

    }
    func setUpImagePicker(){
        imagePicker.delegate = self
        
    }
    @IBAction func onTabSaveData(_ sender: UIButton) {
        uploadImage2()
    }
}
extension TareaExamViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func uploadImage2(){
        let storageRef = Storage.storage().reference().child("\(Auth.auth().currentUser?.uid ?? "").png")
        if let uploadDataImage = self.Imagen.image?.jpegData(compressionQuality: 0.5){
            storageRef.putData(uploadDataImage) {metadata, error in
                if error == nil{
                    storageRef.downloadURL {url, error in
                        print(url?.absoluteString)
                        self.saveUserData(url: url?.absoluteString ?? "")
                    }
                }else{
                    print("Error \(error)")
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[.originalImage] as? UIImage {
            Imagen.image = pickerImage
            Imagen.contentMode = .scaleToFill
        }
        imagePicker.dismiss(animated: true)
    }
}
