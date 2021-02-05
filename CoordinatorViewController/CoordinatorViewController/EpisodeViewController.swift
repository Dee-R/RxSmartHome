//
//  ViewController.swift
//  CoordinatorViewController
//
//  Created by Eddy R on 05/02/2021.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var episodes = [Episode(title: "Episode one"),Episode(title: "Episode TwO"),Episode(title: "Episode three")]
    var didSelect: (Episode) -> () = { _ in}
    var didTapProfile: ()->() = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = episodes[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        // don t push directly to the next view otherwise
        // use the flow outside of this class.
        let episode = episodes[indexPath.row]
        didSelect(episode) // execute cette fonction(closure)
        // la recuperer dans un niveau exterieur
        
    }
    
    @IBAction func showProfile(_ sender: UIBarButtonItem) {
        didTapProfile()
    }
    @IBAction func unwindToHere(segue: UIStoryboardSegue) {
        
    }
    
}

struct Episode {
    var title: String
}
class DetailViewController: UIViewController {
    @IBOutlet weak var label: UILabel? {
        didSet {
            label?.text = episode?.title
        }
    }
    var episode: Episode?
}


class ProfilViewController: UIViewController {
    var person: String = ""
    var didTapClose: ()->() = {}
    @IBAction func close(_ sender: UIBarButtonItem) {
        didTapClose()
    }
}
