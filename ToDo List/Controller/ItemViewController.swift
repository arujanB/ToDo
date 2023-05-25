//
//  ItemViewController.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 03.05.2023.
//

import UIKit

class ItemViewController: UIViewController {
    
    private lazy var itemTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.IDENTIFIER)
//        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .orange
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
        
        itemTableView.dataSource = self
        
        setUpViews()
        setUpConstrains()
    }
}

//MARK: - tableView DataSource
extension ItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.IDENTIFIER, for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        var randomNum = CGFloat.random(in: 120...255)
        cell.backgroundColor = UIColor(red: randomNum/255, green: randomNum/255, blue: randomNum/255, alpha: 1)
        return cell
    }
}

//MARK: - setUpViews and setUpConstrains()
extension ItemViewController{
    func setUpViews() {
        view.addSubview(itemTableView)
    }
    
    func setUpConstrains() {
        itemTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
