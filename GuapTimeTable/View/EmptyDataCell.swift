//
//  EmptyDataCellView.swift
//  Test
//
//  Created by Denis on 15.10.2022.
//

import Foundation
import UIKit

enum EmptyCellErrors {
    case noInternet
    case wrongQuery
}

final class EmptyDataCell: UITableViewCell {
    private let warning = UILabel()
    private let explanation = UILabel()
    static let identifier = "EmptyDataCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(warning)
        contentView.addSubview(explanation)
        setLabelText()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setLayerAppearance()
        setFonts()
        setFrames()
    }

    private func setLayerAppearance() {
        contentView.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 70)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.35
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.backgroundColor = .clear
        contentView.backgroundColor = .darkGray
    }

    private func setFrames() {
        warning.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 20)
        explanation.frame = CGRect(x: 10, y: 40, width: UIScreen.main.bounds.width - 20, height: 20)
    }

    private func setFonts() {
        warning.font = warning.font.withSize(16)
        explanation.font = explanation.font.withSize(14)
    }

    private func setLabelText() {
        warning.text = "Нет данных"
        explanation.text = "Возможно, отсутствует сеть, или такой группы нет"
    }

    public func setErrorExplanations(error: EmptyCellErrors) {
        switch error {
        case .noInternet:
            warning.text = "Нет данных"
            explanation.text = "Отсутствует подключение к сети"
        case .wrongQuery:
            warning.text = "Нет данных"
            explanation.text = "Похоже, группа не выбрана или не существует"
        }
    }

}
