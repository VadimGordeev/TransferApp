//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Vadim on 23/11/2025.
//

import UIKit

protocol UpdatingDataController: AnyObject {
    var updatingData: String { get set }
}

class SecondViewController: UIViewController, UpdatingDataController {

    @IBOutlet var dataTextField: UITextField!
    var updatingData: String = ""
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    @IBAction func saveDataWithProperty (_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach{ viewController in
            (viewController as? UpdatableDataController)?.updatedData = dataTextField.text ?? ""
        }
    }
    
    @IBAction func saveDataWithDelegate (_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else { return }
        destinationController.updatedData = dataTextField.text ?? ""
        
    }
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
