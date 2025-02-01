//
//  ViewController.swift
//  Example
//
//  Created by Thiago dos Santos Martins on 31/01/25.
//

import UIKit
import RequestLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let data = try await Request.request(url: "https://brasilapi.com.br/api/cep/v1/81260200", responseModel: TestModel.self)
                print(data)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
//        Request.request(url: "https://brasilapi.com.br/api/cep/v1/81260200", responseModel: TestModel.self) {
//            result in
//            
//            switch result {
//            case .success(let val):
//                print(val)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }


}

