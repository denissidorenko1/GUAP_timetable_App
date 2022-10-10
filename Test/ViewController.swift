//
//  ViewController.swift
//  Test
//
//  Created by Denis on 18.09.2022.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
    // При задержке и многократном нажатии на кнопку, будет многократно отправлен запрос, и придет сразу несколько фактов, которые перекроют друг друга. Чтобы избежать этого, добавим костыль, блокирующий вызов функции если она еще не завершилась

    @IBOutlet var label: UILabel!
    @IBAction func getFact(sender: UIButton) {
            makeRequest()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestModule = RequestModule.shared
        requestModule.requestTimeTable(group: Group(id: "326", group: ""), teacher: nil, building: nil, room: nil) { week in
            print(week)
        }
    }
    
    
    
    // TODO: Выпилить это, но пусть пока останется как образец
    private func makeRequest() {
        var request = URLRequest(url: URL(string: "https://catfact.ninja/fact")!)
        request.allHTTPHeaderFields = ["authToken": "nil"]
        request.httpMethod = "GET"
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                if let data = data, let fact = try? JSONDecoder().decode(CatFact.self, from: data) {
//                    sleep(2) // имитация задержки
                    DispatchQueue.main.async {
                        self.label.text = fact.fact
                        // впилить сюда completion
                    }
                }
            }
            task.resume()
        }
    }
}

