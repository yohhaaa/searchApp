//
//  ModuleBuilder.swift
//  SearchApp
//
//  Created by Алан Ахмадуллин on 11.04.2022.
//
import UIKit
import Foundation

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let model = ImageStruct(nameOfImage: "1", urlOfImage: "2", image: nil)
        let view = SearchViewController()
        let presenter = MainPresenter(view: view, networkService: Network)
    }
    
    
}
