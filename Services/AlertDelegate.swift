//
//  AlertDelegate.swift
//  MovieQuiz
//
//  Created by Вячеслав Ростовцев on 18.01.2023.
//

import Foundation
import UIKit
protocol AlertDelegate: AnyObject {
    func present (_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? )
}
