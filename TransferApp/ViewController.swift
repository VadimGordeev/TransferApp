//
//  ViewController.swift
//  TransferApp
//
//  Created by Vadim on 23/11/2025.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

