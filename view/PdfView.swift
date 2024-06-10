//
//  Function.swift
//  view
//
//  Created by Laurel Laoang, Jr on 6/9/24.
//
import SwiftUI
import PDFKit
import Foundation

struct PDFViewWrapper: UIViewRepresentable {
    var pdfData: Data?
    var useFallback: Bool

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        
        if let pdfData = pdfData {
            pdfView.document = PDFDocument(data: pdfData)
        } else if useFallback, let path = Bundle.main.path(forResource: "ticket", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let document = PDFDocument(url: url) {
                pdfView.document = document
            }
        }
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let pdfData = pdfData {
            uiView.document = PDFDocument(data: pdfData)
        } else if useFallback, let path = Bundle.main.path(forResource: "ticket", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let document = PDFDocument(url: url) {
                uiView.document = document
            }
        }
    }

}
