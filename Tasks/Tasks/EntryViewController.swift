import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    var completion: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        let title = "Save".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(saveTask))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        var data = [[String: Any]]()
        data.append(["title": field.text ?? ""])
        guard let userDefaults = UserDefaults(suiteName: "group.org.qcri.Tasks") else { return }
        if let taskData = userDefaults.array(forKey: "TaskData") as? [[String: Any]] {
            data.append(contentsOf: taskData)
            userDefaults.set(data, forKey: "TaskData")
            userDefaults.synchronize()
        } else {
            userDefaults.set(data, forKey: "TaskData")
            userDefaults.synchronize()
        }
        navigationController?.popViewController(animated: true)
        completion?(true)
    }
}
