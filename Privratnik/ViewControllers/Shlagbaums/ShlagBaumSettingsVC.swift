//
//  ShlagBaumSettingsVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 28.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit
import MBProgressHUD

class ShlagBaumSettingsVC: UIViewController {
    
    var selectedShlagbaum:Shlagbaum!
    private var isEditingValues = false
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButtonPressed(_ sender: Any) {
        didPressEditButton()
    }
    @IBOutlet weak var shlagbaumNameTextField: UITextField!
    @IBOutlet weak var shlagbaumAdressTextField: UITextField!
    @IBOutlet weak var shlagbaumPhotoButton: RoundedUIButtonWithBorderWhenSelected!
    @IBAction func shlagbaumPhotoButtonPressed(_ sender: Any) {
        importPhoto()
    }
    @IBOutlet weak var oldShlagbaumDescriptionLabel: UILabel!
    @IBOutlet weak var oldShlagbaumImage: UIImageView!
    @IBOutlet weak var oldShlagBaumModernizationButton: RoundedUIButton!
    @IBAction func oldShlagBaumModernizeButtonPressed(_ sender: Any) {
        
    }
    
    
    @IBOutlet weak var deleteShlagBaumButton: UIButton!
    @IBAction func deleteShlagBaumButtonPressed(_ sender: Any) {
        didPressDeleteShlagbaumButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresentation()
        shlagbaumPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        hideKeyboardWhenTappedAround()
    }
    
    private func setupPresentation(){
        
        // Отображение или сокрытие кусочка про модернизацию
        
        if selectedShlagbaum.needsUpdate != nil && selectedShlagbaum.needsUpdate == true
        {
            oldShlagbaumImage.isHidden = false
            oldShlagbaumDescriptionLabel.isHidden = false
            oldShlagBaumModernizationButton.isHidden = false
        } else {
            oldShlagbaumImage.isHidden = true
            oldShlagbaumDescriptionLabel.isHidden = true
            oldShlagBaumModernizationButton.isHidden = true
        }
        
        // Заполнение полей данными
        shlagbaumNameTextField.text = selectedShlagbaum.name
        shlagbaumAdressTextField.text = selectedShlagbaum.adress
        if selectedShlagbaum.photo != nil {
            shlagbaumPhotoButton.setImage(selectedShlagbaum.photo, for: .normal)
        }
        
        // Кнопка удалить шлагбаум или сбросить данные (мой или серверный шлагбаум)
        
        if selectedShlagbaum.needsUpdate == nil {
            deleteShlagBaumButton.setTitle("Сбросить данные", for: .normal)
            return
        }
        
        if selectedShlagbaum.needsUpdate!{
            deleteShlagBaumButton.setTitle("Удалить шлагбаум", for: .normal)}
        else {
            deleteShlagBaumButton.setTitle("Сбросить данные", for: .normal)
        }
        
    }
    
    private func didPressEditButton(){
        isEditingValues = !isEditingValues
        
        if isEditingValues {
            
            // startedEditing
            
            editButton.setTitle("Готово", for: .normal)
            shlagbaumNameTextField.borderStyle = .roundedRect
            shlagbaumNameTextField.isUserInteractionEnabled = true
            shlagbaumNameTextField.textColor = UIColor.duskBlue
            shlagbaumAdressTextField.borderStyle = .roundedRect
            shlagbaumAdressTextField.isUserInteractionEnabled = true
            shlagbaumAdressTextField.textColor = UIColor.duskBlue
            shlagbaumPhotoButton.isUserInteractionEnabled = true
            shlagbaumPhotoButton.layer.borderWidth = 2
            shlagbaumPhotoButton.layer.borderColor = UIColor.duskBlue.cgColor
            
            
        } else {
            
            // done Editing
            
            editButton.setTitle("Изменить", for: .normal)
            shlagbaumNameTextField.borderStyle = .none
            shlagbaumNameTextField.isUserInteractionEnabled = false
            shlagbaumNameTextField.textColor = UIColor.darkGray
            shlagbaumAdressTextField.borderStyle = .none
            shlagbaumAdressTextField.isUserInteractionEnabled = false
            shlagbaumAdressTextField.textColor = UIColor.darkGray
            shlagbaumPhotoButton.isUserInteractionEnabled = false
            shlagbaumPhotoButton.layer.borderWidth = 0
            
            
            saveShlagBaumNewData()
        }
        
    }
    
    private func didPressDeleteShlagbaumButton(){
        
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите удалить шлагбаум?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertActionStyle.destructive, handler: {action in self.removeShlagbaum()}))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: {action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func removeShlagbaum(){
        let destinationIndex = FakeModel.shared.shlagbaumArray.index(){$0.phone == selectedShlagbaum.phone}
        if destinationIndex == nil {return}
        
        guard let barrierID = FakeModel.shared.shlagbaumArray[destinationIndex!].barrier_id,
            let token = UserAPI.shared.getTokenAndPhoneNumber().token,
            let phone = UserAPI.shared.getTokenAndPhoneNumber().phone else
        {return}
        ProgressHUDManager.shared.showHUD()
        NetworkAPI.removeBarrier(phone: phone, token: token, barrierId: barrierID, completion: { [weak self] (result, error) in
            ProgressHUDManager.shared.hideHUD()
            if error != nil {
                self?.displayAlert(error!)
                return
            }
            if let parent = self?.presentingViewController as? ShlagbaumTableVC {
                parent.shlagbaumsTableRequireUpdate = true
            }
            
            // Только пользовательские шлагбаумы по-настоящему удаляются
            if self?.selectedShlagbaum.needsUpdate == true {
                FakeModel.shared.shlagbaumArray.remove(at: destinationIndex!)
            }
            
            // try to remove image from DB
            UserAPI.shared.removeImage(for: barrierID)
            
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
    private func saveShlagBaumNewData(){
        let destinationIndex = FakeModel.shared.shlagbaumArray.index(){$0.phone == selectedShlagbaum.phone}
        
        guard let barrierID = FakeModel.shared.shlagbaumArray[destinationIndex!].barrier_id,
            let token = UserAPI.shared.getTokenAndPhoneNumber().token,
            let phone = UserAPI.shared.getTokenAndPhoneNumber().phone else
        {return}
        
        let adress = shlagbaumAdressTextField.text
        let name = shlagbaumNameTextField.text
        
        ProgressHUDManager.shared.showHUD()
        NetworkAPI.updateBarrier(phone: phone, token: token, barrier_id: barrierID, barrierName: name, address: adress, pointX: nil, pointY: nil, completion: { [weak self] (result, error) in
            ProgressHUDManager.shared.hideHUD()
            if error != nil {
                self?.displayAlert(error!)
                return
            }
            if let parent = self?.presentingViewController as? ShlagbaumTableVC {
                parent.shlagbaumsTableRequireUpdate = true
            }
            
            
            FakeModel.shared.shlagbaumArray[destinationIndex!].adress = self?.shlagbaumAdressTextField.text
            FakeModel.shared.shlagbaumArray[destinationIndex!].name = self?.shlagbaumNameTextField.text
            FakeModel.shared.shlagbaumArray[destinationIndex!].photo = self?.shlagbaumPhotoButton.image(for: .normal)
            
            if let image = self?.shlagbaumPhotoButton.image(for: .normal) {
                UserAPI.shared.saveImage(image: image, for: barrierID)
            }
            
            self?.navigationController?.popViewController(animated: true)
        })
        
    }
}

extension ShlagBaumSettingsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    private func importPhoto() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            shlagbaumPhotoButton.setImage(image, for: .normal)
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
}

