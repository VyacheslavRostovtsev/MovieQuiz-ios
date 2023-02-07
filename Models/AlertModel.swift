//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Вячеслав Ростовцев on 16.01.2023.
//

import Foundation
struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (()->Void)
}
