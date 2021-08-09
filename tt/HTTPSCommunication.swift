//
//  HTTPSCommunication.swift
//  tt
//
//  Created by Diana Princess on 06.08.2021.
//

import UIKit

class HTTPSCommunication: NSObject {
    // Свойство completionHandler в классе - это замыкание, которое будет
    // содержать код обработки полученных с сайта данных и вывода их
    // в интерфейсе нашего приложения.
    var completionHandler: ((Data) -> Void)!
    
    // retrieveURL(_: completionHandler:) осуществляет загрузку данных
    // с url во временное хранилище
    func retrieveURL(_ url: URL, completionHandler: @escaping ((Data) -> Void)) {
        self.completionHandler = completionHandler
            let request: URLRequest = URLRequest(url: url)
            let session: URLSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            let task: URLSessionDownloadTask = session.downloadTask(with: request)
            // Так как задача всегда создается в остановленном состоянии,
            // мы запускаем ее.
            task.resume()
    }
}

extension HTTPSCommunication: URLSessionDownloadDelegate {

    // Данный метод вызывается после успешной загрузки данных
    // с сайта во временное хранилище для их последующей обработки.
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
                // Мы получаем данные на основе сохраненных во временное
                // хранилище данных. Поскольку данная операция может вызвать
                // исключение, мы используем try, а саму операцию заключаем
                // в блок do {} catch {}
                let data: Data = try Data(contentsOf: location)
                // Далее мы выполняем completionHandler с полученными данными.
                // А так как загрузка происходила асинхронно в фоновой очереди,
                // то для возможности изменения интерфейса, которой работает в
                // главной очереди, нам нужно выполнить замыкание в главной очереди.
                DispatchQueue.main.async(execute: {
                    self.completionHandler(data)
                })
            } catch {
                print("Can't get data from location.")
            }
    }
}


