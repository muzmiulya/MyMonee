//
//  MainTabController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let home = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let homeTab = UINavigationController(rootViewController: home)
        let homeImage = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        let homeImageSelected = UIImage(named: "Home_Selected")?.withRenderingMode(.alwaysOriginal)
        homeTab.setNavigationBarHidden(true, animated: false)
        homeTab.tabBarItem = UITabBarItem(title: "Beranda", image: homeImage, selectedImage: homeImageSelected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1)], for: .selected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)], for: .normal)
        homeTab.tabBarItem.tag = 0
        let dream = DreamTableViewController(nibName: String(describing: DreamTableViewController.self), bundle: nil)
        let dreamTab = UINavigationController(rootViewController: dream)
        let dreamImage = UIImage(named: "Dream")?.withRenderingMode(.alwaysOriginal)
        let dreamImageSelected = UIImage(named: "Dream_Selected")?.withRenderingMode(.alwaysOriginal)
        dreamTab.setNavigationBarHidden(true, animated: false)
        dreamTab.tabBarItem = UITabBarItem(title: "Impian", image: dreamImage, selectedImage: dreamImageSelected)
        dreamTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1)], for: .selected)
        dreamTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)], for: .normal)
        dreamTab.tabBarItem.tag = 1
        let profile = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        let profileTab = UINavigationController(rootViewController: profile)
        let profileImage = UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        let profileImageSelected = UIImage(named: "Profile_Selected")?.withRenderingMode(.alwaysOriginal)
        profileTab.setNavigationBarHidden(true, animated: false)
        profileTab.tabBarItem = UITabBarItem(title: "Profil", image: profileImage, selectedImage: profileImageSelected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1)], for: .selected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)], for: .normal)
        profileTab.tabBarItem.tag = 2
        self.viewControllers = [homeTab, dreamTab, profileTab]
    }
}
