//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Вячеслав Ростовцев on 13.01.2023.
//

protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
}
