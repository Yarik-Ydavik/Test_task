//
//  ProductView.swift
//  My_Spar
//
//  Created by Yaroslav Zagumennikov on 03.02.2024.
//

import SwiftUI

struct ProductView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var pvm : ProductViewModel
    
    var body: some View {
        ZStack{
            Color( colorScheme == .light ? UIColor.systemBackground : UIColor.secondarySystemBackground)
                .ignoresSafeArea(.all)
            
            VStack {
                TopBar()
                Divider()
                Product()
                Divider()
                BottomBar()
                Spacer()
            }
            
            
        }
        
    }
}

extension ProductView {
    struct TopBar : View {
        @Environment(\.dismiss) var dismiss
        var body: some View {
            HStack (alignment: .bottom, spacing: 15) {
                ButtonTopBar(action: { dismiss() }, icon: "arrow.left")

                Spacer()
                
                ButtonTopBar(action: { }, icon: "doc.plaintext")
                
                ButtonTopBar(action: { }, icon: "square.and.arrow.up")

                ButtonTopBar(action: { }, icon: "heart")

            }
            .padding()
        }
    }
    
    struct Product : View {
        @EnvironmentObject var pvm : ProductViewModel
        @State var ShowCharacteristics = false
        var body: some View {
            ScrollView {
                // Информация о продукте
                VStack (alignment: .leading, content: {
                    Image("product")
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .topLeading) {
                            Text ("Цена по карте")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(Color.green)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    
                    HStack (spacing: 0) {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                        HStack {
                            Text ("\( Double(pvm.product.reviews.reduce(0){$0 + $1.review } / pvm.product.reviews.count) .description)")
                            Text ("|  "+pvm.product.reviews.count.description + "  отзыва")
                                .fontWeight(.thin)
                            Spacer()
                            Image("sale")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 35, height: 35)
                        }
                    }
                    
                    Text(pvm.product.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    Text(pvm.product.country)
                        .fontWeight(.thin)
                    
                    VStack (alignment: .leading){
                        Text ("Описание")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.vertical, 4)
                        Text (pvm.product.description)
                    }
                    .padding(.vertical)

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Основные характеристики")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.vertical, 4)
                        
                        
                        ForEach(pvm.product.characteristics[...(!ShowCharacteristics ? 3 : pvm.product.characteristics.count-1)]) { item in
                            DotListItem(name: item.key, value: item.value)
                        }
                        
                        
                        Button {
                            withAnimation(.none) {
                                ShowCharacteristics.toggle()
                            }
                        } label: {
                            Text(!ShowCharacteristics ? "Все характеристики" : "Скрыть" )
                                .fontWeight(.black)
                                .foregroundStyle(!ShowCharacteristics ? Color.green : Color.gray)
                        }

                    }
                    .padding(.vertical)

                    HStack (alignment: .center) {
                        Text ("Отзывы")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Button {
                            
                        } label: {
                            Text( "Все \( pvm.product.reviews.count )" )
                                .fontWeight(.black)
                                .foregroundStyle(!ShowCharacteristics ? Color.green : Color.gray)
                        }

                    }
                })
                .frame(width: .infinity, height: .infinity)
                .padding(.horizontal, 20)
                
                // Полоса отзывов
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack (spacing : 20) {
                        ForEach(pvm.product.reviews) { item in
                            ReviewView(reviewer: item)
                        }
                    }
                    .padding()
                }
                .frame(width: .infinity, height: .infinity)
                .padding(.horizontal, 5)
                
                Button(action: {}, label: {
                    Text("Оставить отзыв")
                        .fontWeight(.black)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(content: {
                            RoundedRectangle (cornerRadius: 25)
                                .stroke(lineWidth: 3)
                        })
                        .foregroundStyle(.green)
                })
                .padding()

            }
            
        }
    }
    
    struct BottomBar : View {
        @State var selection = 1
        var body: some View {
            VStack {
                Picker(selection: $selection, label: Text("Picker")) {
                    Text("Шт").tag(1)
                    Text("Кг").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                HStack {
                    VStack (alignment: .leading) {
                        HStack (spacing: 2) {
                            Text("55.9")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("₽/кг")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        
                        Text("199.0")
                            .font(.subheadline)
                            .fontWeight(.thin)
                            .strikethrough()
                        
                    }
                    Spacer()
                    
                    HStack (alignment: .center, spacing: .some(30)) {
                        Button("-") {}
                        VStack{
                            Text("1 шт")
                                .fontWeight(.bold)
                            Text("120,0 ₽")
                                .fontWeight(.thin)
                        }
                        .font(.headline)
                        Button("+") {}
                    }
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding()
                    .frame(width: 180, height: 50)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                }
                .padding()
            }
        }
    }
}

struct ReviewView : View {
    @Environment(\.colorScheme) var colorScheme
    var reviewer : Review
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(reviewer.name)
            Text(reviewer.date.description)
            HStack (spacing : 2) {
                ForEach(1..<6) {i in
                    Image(systemName: "star.fill")
                        .foregroundStyle( i <= reviewer.review ? Color(UIColor.systemYellow) : Color(UIColor.systemGray))
                }
            }
            Text(reviewer.reviewDescription)
        }
        .padding(10)
        .frame(width: 250, height: 180)
        .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
        .background(content: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle( colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
                .shadow(color: Color( colorScheme == .light ?
                    #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1) :
                    #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
                ) , radius: 10)

        })

        
    }
}

struct ButtonTopBar : View {
    var action : () -> Void
    var icon : String
    
    var body: some View {
        Button (action: action, label: {
            Image (systemName: icon)
                .font(.title2.bold())
                .foregroundStyle( Color(UIColor.systemGreen) )
        })
    }
}

struct DotListItem : View {
    var name : String
    var value : String
    var body: some View {
        HStack (alignment: .top, spacing: 5) {
            Text(name)
                .multilineTextAlignment(.leading)
            
            Spacer()
                .overlay {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                        .frame(height: 1)
                        .padding(.top, 30)
                }

            Text(value)
                .multilineTextAlignment(.trailing)
        }

    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}


#Preview {
    Group {
        ProductView()
            .colorScheme(.light)
            .environmentObject(ProductViewModel())

    }
    
    
}
