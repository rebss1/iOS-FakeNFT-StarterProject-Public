import UIKit

struct ErrorModel {
    let message: String
    let actionText: String
    let action: () -> Void
}

struct ErrorModelWithCancel {
    let message: String
    let actionText: String
    let action: () -> Void
}

protocol ErrorView {
    func showError(_ model: ErrorModel)
    func showErrorWithCancel(_ model: ErrorModelWithCancel)
}

extension ErrorView where Self: UIViewController {

    func showError(_ model: ErrorModel) {
        let title = NSLocalizedString("Error.title", comment: "")
        let alert = UIAlertController(
            title: title,
            message: model.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: model.actionText, style: UIAlertAction.Style.default) {_ in
            model.action()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showErrorWithCancel(_ model: ErrorModelWithCancel) {
        let title = model.message
        let alert = UIAlertController(
            title: title,
            message: "",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: model.actionText, style: UIAlertAction.Style.cancel) {_ in
            model.action()
        }
        let secondAction = UIAlertAction(title: NSLocalizedString("Error.cancel", comment: "Отмена"), style: UIAlertAction.Style.default)
        alert.addAction(action)
        alert.addAction(secondAction)
        present(alert, animated: true)
    }
}
