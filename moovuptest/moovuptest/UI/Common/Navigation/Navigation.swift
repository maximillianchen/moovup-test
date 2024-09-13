//
//  Navigation.swift
//  moovuptest
//
//  Created by Max on 13/9/2024.
//

import Foundation

import SwiftUI

struct Navigation: Hashable {
    let action: Action
    let targetViewModel: TargetViewModel
}

extension Navigation {
    enum Action: Hashable {
        case push
        case sheet(config: SheetConfig)
        case fullScreenCover(config: FullScreenCoverConfig)
        case modal(config: ModalConfig)
    }
}

extension Navigation.Action {
    
    struct SheetConfig: Hashable {
        var isStacked: Bool = false
    }
    
    struct FullScreenCoverConfig: Hashable {
        var isStacked: Bool = false
    }
    
    struct ModalConfig: Hashable {
        var dimsBackground: Bool = true
        var transition: Transition = .opacityBottomSlide
        var animationDuration: AnimationDuration = .default
    }
}

extension Navigation.Action {
    enum AnimationDuration {
        case `default`
        case linearFast
        
        func toAnimation() -> Animation {
            switch self {
            case .default:
                return .default
            case .linearFast:
                return .linear(duration: 0.1)
            }
        }
    }
}

extension Navigation.Action.ModalConfig {
    enum Transition {
        case opacity
        case opacityBottomSlide
        case opacityScale
        
        func toAnyTransition() -> AnyTransition {
            switch self {
            case .opacity:
                return .opacity
            case .opacityBottomSlide:
                return .opacity.combined(with: .move(edge: .bottom))
            case .opacityScale:
                return .opacity.combined(with: .scale)
            }
        }
    }
}

extension Navigation {
    enum TargetViewModel: Hashable {
        
        case peopleDetails(viewModel: PeopleDetailsViewModel)
    }
}
