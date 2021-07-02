//
//  AppTabBarController.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 25/02/2021.
//

import UIKit
import ResourcesModule

public class AppTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    static let tabBarHeight: CGFloat = 100
    private let selectedItemLabel = "⬤"
    private var indexOfSelectedTab: Int!
    private var selectedTabbarIcon: UIImageView?
    //
    private var tabs: [UIViewController] = []
    
    public init(tabs: [UIViewController]) {
        self.tabs = tabs
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.configureTabBar()
        self.configureTabBarItems()
        self.tabBar.items?.first?.title = self.selectedItemLabel
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(UIDevice.hasNotch) {
            self.setTabBarHeight()
        }
    }
    
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // The order of execution is very important
        self.resetTabBarItemsLabel()
        item.title = self.selectedItemLabel
        self.performBounceAnimation(on: item)
    }
    
    private func configureTabBarItems() {
        guard self.tabs.count == 4 else {
            fatalError("Please use `init(tabs: [UIViewController])` initialiser and pass four tabs!")
        }
        let homeViewController = tabs[0]
        let homeTitle = "tabbar_home_item_title".localized
        let homeNavController = createTabBarItem(from: homeViewController, title: homeTitle)
        //
        let menuViewController = tabs[1]
        let menuTitle = "tabbar_menu_item_title".localized
        let menuNavController = createTabBarItem(from: menuViewController, title: menuTitle)
        //
        let ordersViewController = tabs[2]
        let ordersTitle = "tabbar_orders_item_title".localized
        let ordersNavController = createTabBarItem(from: ordersViewController, title: ordersTitle)
        //
        let profileViewController = tabs[3]
        let profileTitle = "tabbar_profile_item_title".localized
        let profileNavController = createTabBarItem(from: profileViewController, title: profileTitle)
        //
        viewControllers = [homeNavController, menuNavController, ordersNavController, profileNavController]
    }
    
    private func createTabBarItem(from viewController: UIViewController,
                                  title: String) -> AppNavigationController {
        let navigationController = AppNavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
        return navigationController
    }
    
    private func resetTabBarItemsLabel() {
        self.tabBar.items?.apply {
            $0[0].title = "tabbar_home_item_title".localized
            $0[1].title = "tabbar_menu_item_title".localized
            $0[2].title = "tabbar_orders_item_title".localized
            $0[3].title = "tabbar_profile_item_title".localized
        }
    }
    
    private func configureTabBar() {
        self.configureTabBarAppearance()
        self.configureTabBarItemAppearance()
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        self.setTabBarItemsAppearance(appearance.stackedLayoutAppearance)
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
    }
    
    private func setTabBarItemsAppearance(_ itemAppearance: UITabBarItemAppearance) {
        let tabBarFont = UIFont.appFont(ofSize: 9, weight: .regular)
        let normalItemStyle = [NSAttributedString.Key.foregroundColor: UIColor.fontGray,
                               NSAttributedString.Key.font: tabBarFont]
        let selectedItemStyle = [NSAttributedString.Key.foregroundColor: UIColor.normalOrange,
                                 NSAttributedString.Key.font: tabBarFont]
        itemAppearance.normal.iconColor = .white
        itemAppearance.normal.titleTextAttributes = normalItemStyle
        itemAppearance.selected.iconColor = .normalOrange
        itemAppearance.selected.titleTextAttributes = selectedItemStyle
    }
    
    private func configureTabBarItemAppearance() {
        let image = UIImage()
        self.tabBar.apply {
            $0.barTintColor = UIColor.black
            $0.tintColor = UIColor.normalOrange
            $0.shadowImage = image
            $0.layer.masksToBounds = true
            $0.roundCorners(radius: 20)
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    private func setTabBarHeight() {
        self.tabBar.frame.size.height = AppTabBarController.tabBarHeight
        self.tabBar.frame.origin.y = view.frame.height - AppTabBarController.tabBarHeight
    }
    
    private func performBounceAnimation(on item: UITabBarItem) {
        // Find the index of the selected tabbar item, then find the corresponding view and get its image.
        self.indexOfSelectedTab = self.tabBar.items!.firstIndex(of: item)!
        self.selectedTabbarIcon = self.getTabBarItemImageView(by: indexOfSelectedTab)
        //
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.selectedTabbarIcon?.transform = .rotateClockwise
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.selectedTabbarIcon?.transform = .rotateAntiClockwise
        })
    }
    
    private func getTabBarItemImageView(by index: Int) -> UIImageView? {
        if let itemImageView = getSortedTabBarItemViews()[index].subviews.compactMap({ $0 as? UIImageView }).first {
            itemImageView.contentMode = .center
            itemImageView.transform = CGAffineTransform.identity
            return itemImageView
        }
        return nil
    }
    
    // I didn't use lazy var here because we need to redo this calculation every time, otherwise, the animation and resetting tab bar items label will misbehave when working together.
    private func getSortedTabBarItemViews() -> [UIView] {
        let interactionViews = tabBar.subviews.filter({$0.isUserInteractionEnabled})
        return interactionViews.sorted(by: {$0.frame.minX < $1.frame.minX})
    }
}
