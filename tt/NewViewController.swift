//
//  NewViewController.swift
//  tt
//
//  Created by Diana Princess on 02.08.2021.
//

import UIKit

class NewViewController: UIViewController {
    var receivedInt: Int = 0
    lazy var jokeLabel: UILabel = {
            let label: UILabel = UILabel(frame: CGRect.zero)
            label.lineBreakMode = .byWordWrapping
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16)
            label.sizeToFit()
            self.view.addSubview(label)
            return label
        }()

        // Идентификатор шутки понадобится для второй части статьи.
        var jokeID: Int = 0

        // ActivityView индикатор будет вращаться, пока не будет
        // получена шутка, затем он исчезнет.
        lazy var activityView: UIActivityIndicatorView = {
            let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
            activityView.hidesWhenStopped = true
            activityView.startAnimating()
            view.addSubview(activityView)
            return activityView
        }()
        
    var imageView  = UIImageView(frame:CGRect(x: 65, y: 320, width: 200, height: 200))
    
        lazy var stackView: UIStackView = {
            let mainStackView: UIStackView = UIStackView(arrangedSubviews: [self.jokeLabel])
            // Расстояние между элементами понадобиться во второй части
            mainStackView.spacing = 50
            mainStackView.axis = .vertical
            mainStackView.distribution = .fillEqually
            self.view.addSubview(mainStackView)
            return mainStackView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let oneLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        oneLabel.center = CGPoint(x: 160, y: 184)
        oneLabel.textAlignment = NSTextAlignment.center
        oneLabel.text = "\(receivedInt)"
        self.view.addSubview(oneLabel)
        // Do any additional setup after loading the view.
        self.title = "Chuck Norris Jokes"
        self.view.addSubview(imageView)

                // В данном методе настраивается stackView и activityView,
                // что вызывает инициализацию их ленивых переменных.
                // В свою очередь инициализация stackView вызывает
                // инициализацию ленивой переменной label.
                self.configConstraints()    // (E.2)

                // Данный метод содержит весь функционал по работе
                // с интернетом и получению шутки.
                self.retrieveRandomJokes()    // (E.3)
            }
    struct Joke: Codable {
        var categories: Array<String>
        var created_at: String
        var icon_url: String
        var id: String
        var updated_at: String
        var url: String
        var value: String
    }

                func retrieveRandomJokes() {
                var request = URLRequest(url: URL(string: "https://api.chucknorris.io/jokes/random")!)
                request.httpMethod = "GET"
                request.allHTTPHeaderFields = ["AuthToken": "null"]
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    print(String(decoding: data!, as: UTF8.self))
                    let joke: Joke = try! JSONDecoder().decode(Joke.self, from: data!)
                    print("Begin of code")
                    let url1 = URL(string: joke.icon_url)!
                    self.downloadImage(from: url1)
                    print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
                    DispatchQueue.main.async { [weak self] in
                    self?.jokeLabel.text = joke.value
                    self!.activityView.stopAnimating()
                     }
                }
                task.resume()
            }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url1: URL) {
        print("Download Started")
        getData(from: url1) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url1.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
    }

extension NewViewController {
  
    func configConstraints() {
        // Задаем перевод autoresizingMask в ограничения(constraints)
        // как false, чтобы не создавать конфликт с нашими собственными
        // ограничениями
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor)
            ])

        self.activityView.translatesAutoresizingMaskIntoConstraints = false
        // Активируем массив ограничений (constraints) для activityView,
        // чтобы он показывался на месте label: центр по X и Y равен
        // центру label по X и Y.
        NSLayoutConstraint.activate([
            self.activityView.centerXAnchor.constraint(equalTo: self.jokeLabel.centerXAnchor),
            self.activityView.centerYAnchor.constraint(equalTo: self.jokeLabel.centerYAnchor)
            ])
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
