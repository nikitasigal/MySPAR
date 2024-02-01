//
//  ProductView.swift
//  MySPAR
//
//  Created by Никита Сигал on 31.01.2024.
//

import SwiftUI
import UIKit

// Allow shadows from review cards to bleed outside of their ScrollView
extension UIScrollView {
    override open var clipsToBounds: Bool {
        get { false }
        set {}
    }
}

// Store product properties
private struct ProductProperty {
    var title: String
    var value: String
}

// MARK: Product View

struct ProductView: View {
    // Select how we measure the amount of the product
    private enum AmountMode: String {
        case units = "шт", weight = "кг"
    }
    
    @State private var amountMode: AmountMode = .units
    @State private var amount: Int = 0
    
    // Product's properties (example)
    private let properties: [ProductProperty] = [
        .init(title: "Производство", value: "Россия, Краснодарский Край"),
        .init(title: "Энергетическая ценность, ккал/100 г", value: "25 ккал, 105 кДж"),
        .init(title: "Жиры/100 г", value: "0,1 г"),
        .init(title: "Белка/100 г", value: "1,3 г"),
        .init(title: "Углеводы/100 г", value: "3,3 г"),
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // MARK: Image
                        
                        ZStack(alignment: .topLeading) {
                            Image("product")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                            Text("Цена по карте")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.green)
                                .cornerRadius(4)
                                .padding(4)
                        }
                        .frame(height: 250)
                        .padding(.bottom, -24)
                        
                        // MARK: Rating
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.yellow)
                            
                            Text("4.1")
                                .font(.body)
                            
                            Rectangle()
                                .frame(width: 1, height: 20)
                                .foregroundColor(.gray)
                            
                            Text("19 отзывов")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            ZStack {
                                Image("badge")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .foregroundColor(.red)
                                Text("-5%")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // MARK: Title
                        
                        Text("Добавка \"Липа\" к чаю 200 г")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        // MARK: Origin
                        
                        HStack(spacing: 16) {
                            Image("spain")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                            
                            Text("Испания, Риоха")
                                .font(.footnote)
                        }
                        .padding(.vertical, 4)
                        
                        // MARK: Description
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Описание")
                                .font(.headline)
                            Text("Флавоноиды липового цвета обладают противовоспалительным действием, способствуют укреплению стенки сосудов.")
                                .font(.body)
                        }
                        
                        // MARK: Properties
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Основные характеристики")
                                .font(.headline)
                            ForEach(properties, id: \.title) { property in
                                HStack(alignment: .top, spacing: 0) {
                                    Text(property.title)
                                        .lineLimit(2)
                                    Spacer()
                                    Text("..........................................................")
                                        .lineLimit(1)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text(property.value)
                                        .multilineTextAlignment(.trailing)
                                        .lineLimit(2)
                                }
                                .font(.footnote)
                            }
                        }
                        
                        Button {} label: {
                            Text("Все характеристики")
                                .font(.headline)
                                .bold()
                        }
                        
                        // MARK: Reviews
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Отзывы")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                                Button {} label: {
                                    Text("Все 152")
                                        .font(.headline)
                                        .bold()
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ProductReviewCard()
                                    ProductReviewCard()
                                }
                            }
                        }
                        
                        Button {} label: {
                            Text("Оставить отзыв")
                                .font(.headline)
                                .bold()
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(lineWidth: 4)
                                )
                        }
                    }
                    .padding(16)
                }
                
                // MARK: Bottom Toolbar
                
                VStack(spacing: 8) {
                    Picker("Режим", selection: $amountMode) {
                        Text("Шт").tag(AmountMode.units)
                        Text("Кг").tag(AmountMode.weight)
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("55.9 ₽/" + amountMode.rawValue)
                                .font(.title)
                                .bold()
                            Text("199,0")
                                .font(.callout)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Button {
                                amount = max(0, amount - 1)
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            
                            VStack(spacing: 4) {
                                Text("\(amount) " + amountMode.rawValue)
                                    .font(.headline)
                                    .bold()
                                Text("\(Double(amount) * 55.9, specifier: "%.2f")₽")
                                    .font(.footnote)
                            }
                            .frame(minWidth: 100)
                            
                            Button {
                                amount += 1
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(100)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.white)
                .compositingGroup()
                .shadow(color: .init(white: 0.9), radius: 4, x: 0, y: -2)
            }

            // MARK: Navigation Toolbar

            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {} label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    HStack(alignment: .bottom, spacing: 8) {
                        Button {} label: {
                            Image(systemName: "menucard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        Button {} label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        Button {} label: {
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProductView()
}
