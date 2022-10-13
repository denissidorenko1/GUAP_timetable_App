//
//  LessonTableViewCell.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation
import UIKit

class LessonTableViewCell: UITableViewCell{
    public var count = 0 // костыль чтобы обозначить количество ячеек пар в дне
    static let identifier = "LessonTableViewCell"
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        

        layout.itemSize = CGSize(width: CGFloat(UIScreen.main.bounds.width), height: SettingsView.cellSize - 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isScrollEnabled = false
        return collectionView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .purple
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        collectionView.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)

    }

}

extension LessonTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


