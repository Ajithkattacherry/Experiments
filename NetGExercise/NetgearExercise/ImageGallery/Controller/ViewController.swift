//
//  ViewController.swift
//  NetgearExercise
//
//  Created by Ajith Anthony on 4/7/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var manifestData: ManifestData?
    var pageCount = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMetaData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private Methods
    private func configUI() {
        let index = IndexPath.init(item: 0, section: 0)
        sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        pageControl.currentPage = 0
        pageControl.numberOfPages = manifestData?.imageGroups[pageCount].count ?? 0
    }
    
    private func fetchMetaData() {
        SliderDataServiceManager.shared.getManifestData { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.manifestData = data
                    self.pageCount += 1
                    self.configUI()
                    self.sliderCollectionView.reloadData()
                case .failure(let error):
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: Image Fetch
    /// Load the images from next image group
    @IBAction func getNext() {
        if pageCount + 1 < manifestData?.imageGroups.count ?? 0 {
            pageCount += 1
            configUI()
            sliderCollectionView.reloadData()
        }
    }
    
    /// Load the images from previous image group
    @IBAction func getPrevious() {
        if pageCount > 0 {
            pageCount -= 1
            configUI()
            sliderCollectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, ImageCacheProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manifestData?.imageGroups[pageCount].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        if let imageGroup = manifestData?.imageGroups[pageCount] {
            cell.slideImageView.loadImage(from: imageGroup[indexPath.row], placeholder: "placeholder")
            cell.slideImageView.delegate = self
            cell.imageName.text = retrieveImageData(forKey: imageGroup[indexPath.row])?.name
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(sliderCollectionView.contentOffset.x / sliderCollectionView.frame.width)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}

extension ViewController: SliderImageDelegate {
    func imageLoadDidComplete() {
        sliderCollectionView.reloadData()
    }
}
