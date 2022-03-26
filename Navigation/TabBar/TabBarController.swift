//
//  ViewController.swift
//  Navigation
//
//  Created by Алексей Моторин on 13.02.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile
        case animation
        
        var title: String {
            switch self {
            case .feed:
                return "Лента"
            case .profile:
                return "Профиль"
            case .animation:
                return "Анимация"
            }
        }
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "newspaper.fill")
            case .profile:
                return UIImage(systemName: "person.crop.rectangle")
            case .animation:
                return UIImage(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBAr()
    }

    func setupTabBAr() {
        tabBar.backgroundColor = .white
        let items: [TabBarItem] = [.feed, .profile, .animation]
        
        self.viewControllers = items.map({ tabBarIten in
            switch tabBarIten {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: LogInViewController())
            case .animation:
                return UINavigationController(rootViewController: AnimationViewController())
            }
        })

        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }

}

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}
