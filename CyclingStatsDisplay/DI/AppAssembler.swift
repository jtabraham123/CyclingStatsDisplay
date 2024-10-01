//
//  AppAssembler.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import Foundation
import Swinject

// swinject app assembler, contains resolver for initial coordinator injection
class AppAssembler {
    private let assembler: Assembler
    
    var resolver: Resolver { self.assembler.resolver }
    
    init() {
        self.assembler = Assembler([
            CoordinatorAssembly(),
            ServiceAssembly(),
            ViewModelAssembly()
        ])
    }
}
