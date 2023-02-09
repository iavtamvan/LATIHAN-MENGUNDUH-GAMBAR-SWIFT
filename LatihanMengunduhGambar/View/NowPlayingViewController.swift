//
//  ProfileViewController.swift
//  LatihanMengunduhGambar
//
//  Created by Ade Fajr Ariav on 09/02/23.
//

import UIKit

class NowPlayingViewController: UIViewController, UITableViewDataSource {
   
    
    @IBOutlet var nowPlayingTableView: UITableView!
    
    private var moviesNowPlaying: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nowPlayingTableView.dataSource = self
        
        nowPlayingTableView.register(
            UINib(nibName: "NowPlayingTableViewCell", bundle: nil), forCellReuseIdentifier: "nowPlayingTableView"
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task{await getMovies() }
    }
    
    func getMovies() async {
        let network = NetworkService()
        
        do {
            moviesNowPlaying = try await network.getMovies(movies: "upcoming")
            print(moviesNowPlaying)
            nowPlayingTableView.reloadData()
        } catch {
            fatalError("Error : Connection Failed.")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesNowPlaying.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingTableView",
        for: indexPath
        ) as? NowPlayingTableViewCell{
            let nowPlaying = moviesNowPlaying[indexPath.row]
            cell.lblJudul.text = nowPlaying.title
            
            cell.ivPoster.image = nowPlaying.image
            if nowPlaying.state == .new {
                cell.loadingView.isHidden = false
                cell.loadingView.startAnimating()
                startDownload(nowPlaying: nowPlaying, indexPath: indexPath)
            } else {
                cell.loadingView.stopAnimating()
                cell.loadingView.isHidden = true
            }
            
            cell.loadingView.startAnimating()
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    fileprivate func startDownload(nowPlaying: Movie, indexPath: IndexPath){
        
        let imageDownloader = ImageDownloader()
        if nowPlaying.state == .new {
            Task {
                do {
                    let image = try await imageDownloader.downloadImage(url: nowPlaying.posterPath)
                    nowPlaying.state = .downloaded
                    nowPlaying.image = image
                    self.nowPlayingTableView.reloadRows(at: [indexPath], with: .automatic)
                } catch {
                    nowPlaying.state = .failed
                    nowPlaying.image = nil
                }
            }
        }
    }
    
}
