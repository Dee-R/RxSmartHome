//  //        https://talk.objc.io/episodes/S01E05-connecting-view-controllers?t=164
//  SceneDelegate.swift
//  CoordinatorViewController
//
//  Created by Eddy R on 05/02/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var app: App?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
        if let window = window {
            app = App(window: window)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

final class App{
    // get the episode in ...
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        // 01. get the reference to the navigation controller of Episode viewController
        navigationController = window.rootViewController as! UINavigationController
        //        // 02. get to the episode here ( it s the First Viewcontroler in the NavigationController Stack
        let episodesVC = navigationController.viewControllers[0] as! EpisodeViewController
        
        
        // 03 recupere le code stocker dans la fonction et set la suite du code
        episodesVC.didSelect = showEpisode // le parametre est omis car $0 pour la closure
        episodesVC.didTapProfile = {
            // oublie pas de donner un identifiant a ton viewcontroller ou navigation controller
            let profileNC = self.sb.instantiateViewController(identifier: "ProfilViewController") as! UINavigationController
            let profileVC = profileNC.viewControllers[0] as! ProfilViewController
            profileVC.didTapClose = {
                self.navigationController.dismiss(animated: true, completion: nil)
            }
            self.navigationController.present(profileNC, animated: true, completion: nil)
        }
    }
    
    func showEpisode(episodeData: Episode) {
        // 05. je dois la recuperer depuis le Storyboard et ensuite le caster vers son fichier Code car dans le SB c'est une Pur View qui ne connais pas encore son partenaire ( son fichier code )
        let detailViewController = sb.instantiateViewController(withIdentifier: "DetailsVC") as! DetailViewController
        // 06 ensuite je configure le ( j'envoie les infomations recuperé dans le call back et l'envoie dans la View DetailsViewController
        detailViewController.episode = episodeData
        // 04. ici je veux aller au DetailsViewController mais ...
        navigationController.pushViewController(detailViewController , animated: true)
    }
    
    
}

