//
//  MainTableViewCell.swift
//  ToDo List
//
//  Created by Aruzhan Boranbay on 03.05.2023.
//

import UIKit
import SnapKit
import CoreData

class MainTableViewCell: UITableViewCell {
    static let IDENTIFIER = "MainTableViewCell"
    
    private lazy var myLabel: UILabel = {
        var label = UILabel()
        label.text = "Label"
        return label
    }()
    
    private lazy var priority: UILabel = {
        var label = UILabel()
        label.text = "Priority"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String, priority: Int16 = 26) {
        myLabel.text = name
        self.priority.text = " Priority: \(priority)"
    }

}

//MARK: - setUpViews and setUpConstrains()
extension MainTableViewCell{
    func setUpViews(){
        contentView.addSubview(myLabel)
        contentView.addSubview(priority)
    }
    
    func setUpConstraints() {
        myLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        priority.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.leading.equalTo(myLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
