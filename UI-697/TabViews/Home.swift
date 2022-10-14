//
//  Home.swift
//  UI-697
//
//  Created by nyannyan0328 on 2022/10/14.
//

import SwiftUI

struct Home: View {
    @State var currentIndex : Int = 0
    
    @State var showDetailView : Bool = false
    @State var currentDetailPlant : Plant?
      @Namespace var animation
    var body: some View {
      
        ScrollView(.vertical,showsIndicators: false){
            
            VStack{
                
                HeaderView()
                
                
                SearchView()
                
                PlantsView()
                
                
            }
            .padding(15)
            .padding(.bottom,50)
            
            
            
        }
        .padding(15)
        .overlay {
            if let currentDetailPlant,showDetailView{

                DetailView(showView: $showDetailView, plant: currentDetailPlant, animation: animation)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(x:0.5)))


            }
        }

    }
    @ViewBuilder
    func PlantsView ()->some View{
     
        VStack(alignment:.leading,spacing: 10){
            
            HStack(spacing:13){
                
                Image("Grid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 13,height: 13)
                
                Text("Most Popular")
                    .font(.title.weight(.light))
                      .frame(maxWidth: .infinity,alignment: .leading)
                
                
                Button("Show All"){
                    
                    
                    
                }
                .font(.caption)
                .foregroundColor(.gray)
            
            }
            .padding(.leading,1)
            
            CustomCrouselView(index: $currentIndex, items: plants,spacing: 25, cardPadding: 90, id: \.id) { plant, size in
                
                plantsCardView(plant: plant, size: size)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        hideTabBar()
                        withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.8,blendDuration: 0.7)){
                         
                            showDetailView = true
                            currentDetailPlant = plant
                        }
                    }
                
            }
            .frame(height: 400)
            .padding(.top)
            .padding(.horizontal,10)
            
            
            
        }
        
    }
    @ViewBuilder
    func plantsCardView(plant : Plant,size : CGSize)->some View{
        
        ZStack{
            
            LinearGradient(colors: [Color("Card Top"),Color("Card Bottom")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            VStack{
                
                
                Button {
                    
                } label: {
                    
                 
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .padding(10)
                        .foregroundColor(Color("Green"))
                        .background{
                         
                          RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.white)
                        }
                    
                  
                   
                }
                .frame(maxWidth: .infinity,alignment: .topTrailing)
                .padding(15)
                
                VStack{
                    
                    if currentDetailPlant?.id == plant.id && showDetailView{
                        
                        Rectangle()
                            .fill(.clear)
                    }
                    else{
                        
                        Image(plant.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: plant.id, in: animation)
                            .padding(.bottom,-35)
                            .padding(.top,-40)
                    }
                }
                .zIndex(1)
                
                
                HStack(spacing: 13) {
                    
                    VStack(alignment:.leading,spacing: 10){
                        
                        Text(plant.plantName)
                            .font(.callout.weight(.heavy))
                            
                        
                        Text(plant.price)
                            .font(.callout.weight(.heavy))
                        
                        
                    }
                    .lineLimit(1)
                      .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    Button {
                        
                    } label: {
                     
                        Image("Cart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                             .frame(width: 30,height: 30)
                             .foregroundColor(.white)
                             .frame(width: 50,height: 50)
                             .background{
                              
                                 RoundedRectangle(cornerRadius: 10, style: .continuous)
                                     .fill(.black)
                             }
                        
                    }
                    
                    
                    
                    
                    
                }
                .padding([.horizontal,.top],15)
                  .frame(maxWidth: .infinity,alignment: .center)
                .frame(height: 100)
                 .background{
                
                     RoundedRectangle(cornerRadius: 10, style: .continuous)
                         .fill(.white)
                }
                 .padding(10)
                 .zIndex(1)
                
                
                
            }
            
            
        }
        
      
        
    }
    @ViewBuilder
    func SearchView ()->some View{
        
        HStack{
            
            HStack(spacing: 15) {
                
                Image("Search")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                     .frame(width: 30,height: 30)
                   
                Divider()
                    .padding(.vertical,-6)
                
                TextField("SEARCH", text: .constant(""))
               
                
            }
            .padding(15)
            .background{
             
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(.white)
                    
            }
            
            Button {
                
            } label: {
             
                Image("Filter")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                     .frame(width: 30,height: 30)
                     .foregroundColor(.white)
                     .padding(13)
                     .background{
                         
                         RoundedRectangle(cornerRadius: 5,style: .continuous)
                             .fill(.black)
                     }
                     
                
                
            }
       
        }
        .padding(.top,15)
        
    }
    @ViewBuilder
    func HeaderView ()->some View{
        
        HStack{
            
            VStack(alignment:.leading,spacing: 10){
             
                Text("Welcom☃️")
                    .font(.title.bold())
                
              (
                Text("Snow")
                    .font(.largeTitle)
                
                + Text(" Man")
              
              )
                
                
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            
            Button {
                
            } label: {
              Image(systemName: "bell")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(15)
                    .background{
                     
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                
            }
            .overlay(alignment: .topTrailing) {
             
                Text("1")
                    .foregroundColor(.white)
                    .padding(7)
                    .background{
                       Circle()
                            .fill( Color("Green"))
                    }
                     .offset(x:-5,y:-20)
                
                
                
            }
            
            
            
        }
     
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
