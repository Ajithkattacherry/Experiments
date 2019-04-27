//
//  PDFViewController.swift
//  NetworkSession
//
//  Created by Ajith Anthony on 4/27/19.
//  Copyright © 2019 Ajith Anthony. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfView = PDFView()
    var pdfURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pdfView)
        
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }
}
