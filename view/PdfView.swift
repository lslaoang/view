//
//  Function.swift
//  view
//
//  Created by Laurel Laoang, Jr on 6/9/24.
//
import SwiftUI
import PDFKit


struct PDFViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        if let path = Bundle.main.path(forResource: "ticket", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let document = PDFDocument(url: url) {
                pdfView.document = document
            }
        }
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Update the view if needed
    }
}
