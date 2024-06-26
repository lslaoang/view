//
//  ContentView.swift
//  view
//
//  Created by Laurel Laoang, Jr on 6/9/24.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    var body: some View {
        PDFViewer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct PDFViewer: View {
    @State private var isPDFDisplayed = false
    @StateObject private var viewModel = PDFViewModel()

    var body: some View {
        ZStack {
            HexBackgroundView()
                .opacity(0.09)
                .edgesIgnoringSafeArea(.all)
        
            if isPDFDisplayed {
                if let pdfData = viewModel.pdfData {
                    PDFViewWrapper(pdfData: pdfData, useFallback: false)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                } else if viewModel.hasError {
                    PDFViewWrapper(pdfData: nil, useFallback: true)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
            } else {
                VStack {
                    Spacer()

                    Button(action: {
                        withAnimation {
                            isPDFDisplayed = true
                            viewModel.fetchPDF()
                        }
                    }) {
                        Text("Open PDF")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .foregroundColor(.white)
                            .padding()
                    }

                    Spacer()
                }
            }

            if isPDFDisplayed {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                isPDFDisplayed = false
                            }
                        }) {
                            HStack {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title)
                            }
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.red.opacity(0.5))
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding(.top, 40)
                    Spacer()
                }
            }
        }
    }
}

struct HexBackgroundView: View {
    @State private var hexString = generateRandomHex()
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    static func generateRandomHex() -> String {
        let hexValues = "0123456789ABCDEF"
        return (0..<512).map { _ in String(hexValues.randomElement()!) }.joined(separator: "")
    }

    var body: some View {
        Text(hexString)
            .font(.system(size: 30, weight: .regular, design: .monospaced))
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .padding()
            .onReceive(timer) { _ in
                hexString = HexBackgroundView.generateRandomHex()
            }
    }
}

#Preview {
    ContentView()
}

