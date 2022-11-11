//
//  UpdateProfileViewController.swift
//  Intagram-Tecsup-LGuzman
//
//  Created by MAC35 on 4/11/22.
//
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtBio: UITextField!
    @IBOutlet weak var Profileimage: UIImageView!
    
    
    //para poder acceder a la galeria o camara se debe instanciar a UIImage picker controller
    let imagePicker = UIImagePickerController()
    //para poder
    let db = Firestore.firestore()
    
    @IBAction func OntabOpenCallery(_ sender: UIButton) {
        imagePicker.isEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Profileimage.layer.cornerRadius = 40
        getCurrentUser()
        setUpImagePicker()
        getUserDocument()
    }
    
    func getCurrentUser(){
        let user = Auth.auth().currentUser
        txtEmail.text = user?.email
        txtName.text = user?.displayName
    }
    func saveUserData(url : String){
        db.collection("users").document(Auth.auth().currentUser?.uid ?? "no-id").setData([
            "name" : txtName.text!,
            "email" : txtEmail.text!,
            "username" : txtUser.text!,
            "bio" : txtBio.text!,
            "image": url
        ])
    }
    func imageFromURL(url: String ){
        let imageURL = URL (String: url)
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data {
            Profileimage.image = UIImage(data: imageData)
            Profileimage.contentMode = .scaleAspectFill
        }
    }
    
    func getUserDocument(){
        let user = db.collection("users").document(Auth.auth().currentUser?.uid ?? "no-id")
        user.getDocument{ document, error in
            if error == nil {
                let data = document?.data()
                self.txtBio.text = data!["bio"] as? String
                self.txtName.text = data!["name"] as? String
                self.txtEmail.text = data!["email"] as? String
                self.txtUser.text = data!["username"] as? String
                self.imageFromURL(url: data!["image"] as? String ?? "")
            }
        }
    }
    @IBAction func onTabSaveData(_ sender: UIButton) {
        uploadImage()
    }
    
    func setUpImagePicker(){
        imagePicker.delegate = self
    }
    
    @IBAction func onTabBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
extension UpdateProfileViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func uploadImage(){
        let storageRef = Storage.storage().reference().child("\(Auth.auth().currentUser?.uid ?? "").png")
        if let uploadDataImage = self.Profileimage.image?.jpegData(compressionQuality: 0.5){
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
            Profileimage.image = pickerImage
            Profileimage.contentMode = .scaleToFill
        }
        imagePicker.dismiss(animated: true)
    }
}

