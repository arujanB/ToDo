//
//  CreateViewController.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 30.05.2023.
//

import UIKit
import SnapKit

class CreateViewController: UIViewController {
    
    private lazy var selectedPriority: String = Priority.allCases[1].rawValue
    private var sectionToCreate: ToDoSection?
    
    private lazy var nameTextField: ViewTextField = {
        let textField = ViewTextField()
        textField.textFiled.placeholder = "Name"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var descriptionTextField: ViewTextField = {
        let textField = ViewTextField()
        textField.textFiled.placeholder = "Description"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var priorityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        priorityPickerView.dataSource = self
        priorityPickerView.delegate = self

        setNav()
        
        setUpViews()
        setUpConstaints()
    }
    
    func setSection(with section: ToDoSection) {
        self.sectionToCreate = section
    }
    
    @objc func submitButtonPressed() {
        print("\(nameTextField.textFiled.text) and \(descriptionTextField.textFiled.text)")
        if let name = nameTextField.textFiled.text, !name.isEmpty, let desc = descriptionTextField.textFiled.text, !desc.isEmpty {
            ItemManager.shared.createItem(name: name, description: desc, priority: selectedPriority, section: sectionToCreate!)
            navigationController?.popViewController(animated: true)
        }else {
            let alert = UIAlertController(title: "Error", message: "Fill all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
            present(alert, animated: true)
        }
        
    }
    
}

//MARK: - PickerView DataSource
extension CreateViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Priority.allCases.count
    }
}

//MARK: - PickerView Delegate
extension CreateViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Priority.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = Priority.allCases[row].rawValue
    }
}

//MARK: - title Navigation Bar
extension CreateViewController{
    func setNav() {
        navigationItem.title = "Create Item"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
    }
}

//MARK: - setUpViews and setUpConstraints
extension CreateViewController {
    func setUpViews() {
        view.addSubview(nameTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(priorityPickerView)
        view.addSubview(submitButton)
    }
    
    func setUpConstaints(){
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(5)
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(5)
        }

        priorityPickerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(5)
            make.height.equalTo(50)
        }

        submitButton.snp.makeConstraints { make in
            make.top.equalTo(priorityPickerView.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(5)
        }
    }
}

//MARK: - class ViewTextField
class ViewTextField: UIView {
    let textFiled: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.textColor = .label
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textFiled)
        textFiled.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
