//
//  Module.swift
//  SearchApp
//
//  Created by Алан Ахмадуллин on 27.03.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func  createMainModule() -> UIViewController {
        let view = SearchViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.present = presenter
        return view
    }
}
