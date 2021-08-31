//
//  Web.swift
//  tt
//
//  Created by Diana Princess on 31.08.2021.
//

import Foundation
protocol Web {
    var screen : NewViewController! { get }
    var helper3 : URL! { get }
    func retrieveRandomJokes()
    func getData(from helper3: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    func downloadImage()
}
