//
//  File.swift
//  Navigation
//
//  Created by Алексей Моторин on 20.03.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
