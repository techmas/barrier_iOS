//
//  ShlagBaumSettingsVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 28.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var shlagbaumPhotoButton: UIButton!
    @IBAction func shlagbaumPhotoButtonPressed(_ sender: Any) {
        
    }
    @IBOutlet weak var oldShlagbaumDescriptionLabel: UILabel!
    @IBOutlet weak var oldShlagbaumImage: UIImageView!
    @IBOutlet weak var oldShlagBaumModernizationButton: RoundedUIButton!
    @IBAction func deleteShlagBaumButtonPressed(_ sender: Any) {
        didPressDeleteShlagbaumButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresentation()
        
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
        
    }
    
    private func didPressEditButton(){
        isEditingValues = !isEditingValues
        
        if isEditingValues {
            
            // startedEditing
            
            editButton.setTitle("Готово", for: .normal)
            shlagbaumNameTextField.borderStyle = .roundedRect
            shlagbaumNameTextField.isUserInteractionEnabled = true
            shlagbaumNameTextField.textColor = UIColor.darkGray
            shlagbaumAdressTextField.borderStyle = .roundedRect
            shlagbaumAdressTextField.isUserInteractionEnabled = true
            shlagbaumAdressTextField.textColor = UIColor.darkGray
            shlagbaumPhotoButton.isUserInteractionEnabled = true
            
            
        } else {
            
            // done Editing
            
            editButton.setTitle("Изменить", for: .normal)
            shlagbaumNameTextField.borderStyle = .none
            shlagbaumNameTextField.isUserInteractionEnabled = false
            shlagbaumNameTextField.textColor = UIColor.duskBlue
            shlagbaumAdressTextField.borderStyle = .none
            shlagbaumAdressTextField.isUserInteractionEnabled = false
            shlagbaumAdressTextField.textColor = UIColor.duskBlue
            shlagbaumPhotoButton.isUserInteractionEnabled = false
            
            
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
        FakeModel.shared.shlagbaumArray.remove(at: destinationIndex!)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func saveShlagBaumNewData(){
        let destinationIndex = FakeModel.shared.shlagbaumArray.index(){$0.phone == selectedShlagbaum.phone}
        
        FakeModel.shared.shlagbaumArray[destinationIndex!].adress = shlagbaumAdressTextField.text
        FakeModel.shared.shlagbaumArray[destinationIndex!].name = shlagbaumNameTextField.text
    }


}
