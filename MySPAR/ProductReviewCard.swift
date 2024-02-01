//
//  ProductReviewCard.swift
//  MySPAR
//
//  Created by Никита Сигал on 31.01.2024.
//

import SwiftUI

struct ProductReviewCard: View {
    private var rating: Double = 4.0

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Александр В.")
                .font(.headline)
                .bold()

            Text("7 мая 2021")
                .font(.body)
                .foregroundColor(.gray)

            HStack(spacing: 4) {
                ForEach(1 ..< 6) { i in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(i <= Int(round(rating)) ? .yellow : .init(white: 0.85))
                }
            }
            .padding(.bottom, 8)

            Text("Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими!")
                .font(.callout)
                .lineLimit(3)
        }
        .padding(12)
        .frame(width: 280, alignment: .leading)
        .compositingGroup()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .init(white: 0.9), radius: 8)
    }
}

#Preview {
    ProductReviewCard()
}
