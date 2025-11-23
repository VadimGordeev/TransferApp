//
//  ViewController.swift
//  TransferApp
//
//  Created by Vadim on 23/11/2025.
//

import UIKit

protocol UpdatableDataController: AnyObject {
    var updatedData: String { get set }
}

class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
    var updatedData: String = "Test data"
    @IBOutlet var dataLabel: UILabel!

    @IBAction func editDataWithProperty(_ sender: UIButton) {
//        получаем вью контроллер, в который происходит переход
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(
            withIdentifier: "SecondViewController"
        ) as! UpdatingDataController
        
//        передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
//        переходим к следующему экрану
        self.navigationController?
            .pushViewController(editScreen as! UIViewController, animated: true)
    }
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(
            withIdentifier: "SecondViewController"
        ) as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
//        устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(
            withIdentifier: "SecondViewController"
        ) as! SecondViewController
//        передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
//        передаем замыкание
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
//        открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        определяем индентификатор segue
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }

    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
//        безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
}

