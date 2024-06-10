//
//  PDFViewModel.swift
//  view
//
//  Created by Laurel Laoang, Jr on 6/10/24.
//

import Foundation

class PDFViewModel: ObservableObject {
    @Published var pdfData: Data?
    @Published var hasError: Bool = false
    
    private var timer: Timer?

    init() {
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.fetchPDF()
        }
        fetchPDF()
    }
    
    func fetchPDF() {
        guard let url = URL(string: "http://localhost:9090") else {
            self.hasError = true
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error as NSError?, error.code == NSURLErrorCannotConnectToHost {

                DispatchQueue.main.async {
                    self.hasError = true
                    self.pdfData = nil
                }
            } else if let data = data {
                DispatchQueue.main.async {
                    self.pdfData = data
                    self.hasError = false
                }
            }
        }
        
        task.resume()
    }
}




