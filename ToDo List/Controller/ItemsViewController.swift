//
//  ViewController.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 06.04.2023.
//

import UIKit
import SnapKit

class ItemsViewController: UIViewController {
    
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [ToDoItem]()
    private var seactionModel: ToDoSection?
    
//    private lazy var filteredmodels = models
    
    private lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private lazy var myTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.IDENTIFIER)
//        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
//        getAllItems()
        ItemManager.shared.delegate = self
        ItemManager.shared.getAllItems(section: seactionModel!)
//        ItemManager.shared.getAllItems()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        searchBar.delegate = self
        setNav()
        
        setUpViews()
        setUpConstrains()
    }
    
    func setSection(with section: ToDoSection) {
        self.seactionModel = section
    }
    
    @objc private func buttonTapped() {
//        let alert = UIAlertController(title: "New Item", message: "Fill to add it", preferredStyle: .alert)
//        alert.addTextField()
//        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
//            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
//            ItemManager.shared.createItem(with: text/*, section: <#ToDoSection#>*/)
////            self.createItem(with: text)
//        }))
//        present(alert, animated: true)
        let view = CreateViewController()
        view.setSection(with: seactionModel!)
        print("tappet")
        navigationController!.pushViewController(view, animated: true)
    }
    
//    func getAllItems() {
//        do {
//            models = try context.fetch(ToDoItem.fetchRequest())
//            DispatchQueue.main.async {
//                self.myTableView.reloadData()
//            }
//        }catch {
//            print("Error adding data", error)
//        }
//    }
    
//    func createItem(with name: String) {
//        let newItem = ToDoItem(context: context) //creat the newItem constant class ToDoItem and context is mean get access to save the data to local database
//        newItem.name = name
//        newItem.cretedAt = Date()
//        do{
//            try context.save()
//            getAllItems()
//        }catch{
//            print("Error adding data", error)
//        }
//    }
//
//    func deleteItem(item: ToDoItem) {
//        context.delete(item)
//
//        do {
//            try context.save()
//            getAllItems()
//        }catch{
//            print("Error adding data", error)
//        }
//    }

}

//MARK: - DataManagerDelegate {
extension ItemsViewController: ItemManagerDelegate{
    func didUpdateModelList(with model: [ToDoItem]) {
        self.models = model
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error adding data", error)
    }
    
}

//MARK: - tableView DataSource
extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.IDENTIFIER, for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: models[indexPath.row].name!, priority: models[indexPath.row].priority)
        var randomNum = CGFloat.random(in: 120...255)
        cell.backgroundColor = UIColor(red: randomNum/255, green: randomNum/255, blue: randomNum/255, alpha: 1)
        return cell
    }
}

//MARK: - tableView Delegate
extension ItemsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Update", style: .default, handler: { _ in
            
//            let alert = UIAlertController(title: "Edit Item", message: "Fill to update it", preferredStyle: .alert)
//            alert.addTextField()
//            alert.textFields?[0].text = self.models[indexPath.row].name
//            alert.textFields?[1].text = self.models[indexPath.row].desc
//
//            alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
//                guard let field = alert.textFields?[0], let text = field.text, !text.isEmpty, let field2 = alert.textFields?[1], let desc = field2.text, !desc.isEmpty else { return }
//                ItemManager.shared.updatedItem(item: self.models[indexPath.row], newName: text, newDesc: desc, section: self.models[indexPath.section].section!)
//
////                (item: self.models[indexPath.row], newName: text/*, section: sec*/)
//            }))
//            self.present(alert, animated: true)
            let view = CreateViewController()
            self.navigationController?.pushViewController(view, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            guard let sect = self.models[indexPath.row].section else { return }
            ItemManager.shared.deleteItem(item: self.models[indexPath.row], section: sect)
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(sheet, animated: true)
        
        myTableView.reloadData()
    }
}

//MARK: - SearchBar Delegate
extension ItemsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ItemManager.shared.getAllItems(with: searchText, section: seactionModel!)
//        if searchText == "" {
//            filteredmodels = models
//        }else {
//            filteredmodels.removeAll()
//            for model in models {
//                if let name = model.name, name.contains(searchText) {
//                    filteredmodels.append(model)
//                }
//            }
//        }
//        DispatchQueue.main.async {
//            self.myTableView.reloadData()
//        }
        
    }
}

//MARK: - NavigationBar title
extension ItemsViewController {
    func setNav() {
        navigationItem.title = "ToDo"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = add
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = true //to change the size of the title
    }
}

//MARK: - setUpViews and setUpConstrains()
extension ItemsViewController{
    func setUpViews() {
        view.addSubview(searchBar)
        view.addSubview(myTableView)
    }
    
    func setUpConstrains() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        searchBar.searchTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

