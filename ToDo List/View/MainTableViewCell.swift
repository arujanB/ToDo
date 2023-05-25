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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String) {
        myLabel.text = name
    }

}

//MARK: - setUpViews and setUpConstrains()
extension MainTableViewCell{
    func setUpViews(){
        contentView.addSubview(myLabel)
    }
    
    func setUpConstraints() {
        myLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
    }
}
