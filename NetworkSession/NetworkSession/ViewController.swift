//
//  ViewController.swift
//  NetworkSession
//
//  Created by Ajith Anthony on 4/25/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let session = URLSession.shared
    var pdfURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func getJSONData() {
        guard let url = URL(string: "http://demo0736356.mockable.io/jsonEncodeTest") else { return }
        session.dataTask(with: url) { (data, response, error) in
            if let _response = response {
                print(_response)
            }
            if let _data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: _data, options: [])
                    print(json)
                } catch let error {
                    print(error)
                }
            }
            if let _error = error {
                print(_error)
            }
            }.resume()
    }
    
    @IBAction func postJSONData() {
        
    }
    
    @IBAction func downloadData() {
        guard let url = URL(string: "https://www.otago.ac.nz/library/pdf/Google_searching.pdf") else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    @IBAction func openPDFButtonPressed(_ sender: Any) {
        let pdfViewController = PDFViewController()
        guard let pdfURL = self.pdfURL else {
            showAlert(title: "Warning!", message: "Click Download button for pdf file", style: .alert)
            return
        }
        pdfViewController.pdfURL = pdfURL
        present(pdfViewController, animated: false, completion: nil)
    }
}

extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}

