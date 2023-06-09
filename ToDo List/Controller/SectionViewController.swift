//
//  ItemViewController.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 03.05.2023.
//

import UIKit

class SectionViewController: UIViewController {
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var sectionModel = [ToDoSection]()
    
    private lazy var sectionTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.IDENTIFIER)
//        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .orange
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()
        view.backgroundColor = .purple
        
        sectionTableView.dataSource = self
        sectionTableView.delegate = self
        
        SectionManager.shared.delegate = self
        SectionManager.shared.getAllSection()
//        getAllSection()
        
        setUpViews()
        setUpConstrains()
    }
    
    @objc func buttonTapped() {
        let alert = UIAlertController(title: "Add Section", message: "Fill It", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            print("Creating Section")
            guard let field = alert.textFields?[0], let text = field.text else { return }
//            self.createSection(with: text)
            SectionManager.shared.createSection(with: text)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("tapped")
        }))
        present(alert, animated: true)
    }
}

//MARK: - functions: CREATE, DELETE, UPDATE to add local database
extension SectionViewController: SectionManagerDelegate {
    
    func didUpdate(with model: [ToDoSection]) {
        sectionModel = model
        DispatchQueue.main.async {
            self.sectionTableView.reloadData()
        }
    }
    
    func didFail(with error: Error) {
        print("Error adding data", error)
    }
    
//    func getAllSection() {
//        do{
//            sectionModel = try context.fetch(ToDoSection.fetchRequest())
//            DispatchQueue.main.async {
//                self.sectionTableView.reloadData()
//            }
//        }catch {
//            print("error Section", error)
//        }
//    }
//    
//    func createSection(with text: String) {
//        let sectionData = ToDoSection(context: context)
//        sectionData.name = text
//        
//        do{
//            try context.save()
//            getAllSection()
//        }catch{
//            print("Error", error)
//        }
//    }
//    
//    func deleteSection(with section: ToDoSection) {
//        context.delete(section)
//        
//        do{
//            try context.save()
//            getAllSection()
//        }catch {
//            print("error", error)
//        }
//    }
//    
//    func updateSection(with section: ToDoSection, to newName: String) {
//        section.name = newName
//        do{
//            try context.save()
//            getAllSection()
//        }catch{
//            print("error", error)
//        }
//    }
}

//MARK: - tableView DataSource
extension SectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.IDENTIFIER, for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        cell.configure(with: sectionModel[indexPath.row].name ?? "")
        var randomNum = CGFloat.random(in: 120...255)
        cell.backgroundColor = UIColor(red: randomNum/255, green: randomNum/255, blue: randomNum/255, alpha: 1)
        return cell
    }
}

//MARK: - tabeView Delegate
extension SectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = ItemsViewController()
        view.setSection(with: sectionModel[indexPath.row])
        navigationController?.pushViewController(view, animated: true)
        print("Hiiii")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _ in
//            self.deleteSection(with: self.sectionModel[indexPath.row])
                SectionManager.shared.deleteSection(with: self.sectionModel[indexPath.row])
        }),
            UIContextualAction(style: .normal, title: "Edit", handler: { _, _, _ in
            let alert = UIAlertController(title: "Edit Section", message: "", preferredStyle: .alert)
            alert.addTextField()
                alert.textFields?.first?.text = self.sectionModel[indexPath.row].name
            alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
                guard let field = alert.textFields?.first, let text = field.text else { return }
                SectionManager.shared.updateSection(with: self.sectionModel[indexPath.row], to: text)
            }))
            
                self.present(alert, animated: true)
        })
        ])
    }
    
}

//MARK: - set NavigaionBar
extension SectionViewController {
    func setNav() {
        navigationItem.title = "To Do"
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = addBarButton
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = true //to change the size of the title
    }
}

//MARK: - setUpViews and setUpConstrains()
extension SectionViewController{
    func setUpViews() {
        view.addSubview(sectionTableView)
    }
    
    func setUpConstrains() {
        sectionTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
