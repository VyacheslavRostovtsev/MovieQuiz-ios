

import Foundation
import UIKit

//class AlertPresenter: AlertPresenterProtocol {
//    var viewController: UIViewController
//    init(viewController: UIViewController){
//        self.viewController = viewController
//    }
//    func showAlert(model:AlertModel){
//        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
//
//        let action = UIAlertAction(title: model.buttonText, style: .default, handler: model.completion)
//        alert.addAction(action)
//        viewController.present(alert, animated: true)
//    }
//}
class AlertPresenter: AlertPresenterProtocol {
    weak var delegate: AlertDelegate?

    init(delegate: AlertDelegate?) {
        self.delegate = delegate
    }
    func showAlert (model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)

        let action = UIAlertAction(title: model.buttonText,style: .default) {_ in
            model.completion()}
        alert.addAction(action)
        delegate?.present(alert,animated: true, completion: nil)
    }
}
