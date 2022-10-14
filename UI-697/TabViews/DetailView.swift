//
//  DetailView.swift
//  UI-697
//
//  Created by nyannyan0328 on 2022/10/14.
//

import SwiftUI

struct DetailView: View {
    @Binding var showView : Bool
    var plant : Plant
    var animation : Namespace.ID
    @State var showContent : Bool = false
    var body: some View {
        GeometryReader{
            
            let size = $0.size
            
            VStack(spacing: -30){
                
                Image(plant.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: plant.id, in: animation)
                    .frame(width: size.width - 50,height: size.height / 1.6,alignment: .bottom)
                    .zIndex(1)
                
                VStack(spacing: 10){
                    
                 
                        
                        
                        HStack{
                            
                            Text(plant.plantName)
                                .font(.title.bold())
                                .lineLimit(1)
                                .frame(maxWidth: .infinity,alignment: .leading)
                            
                            Text(plant.price)
                                .font(.title3)
                                .foregroundColor(.black)
                                .background{
                                 
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.green.opacity(0.3))
                                }
                        }
                        
                        
                        Text("SAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPLSAMPL")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        
                        Button {
                            
                        } label: {
                         
                            Text("By Now")
                                .font(.title2.weight(.semibold))
                                  .frame(maxWidth: .infinity,alignment: .center)
                                .overlay(alignment: .leading) {
                                    
                                    Image("Cart")
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fill)
                                     .frame(width: 30,height: 30)
                                
                                    
                                }
                            
                        }
                    
                        .foregroundColor(.white)
                        .padding()
                        .background{
                         
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.black)
                        }
                        .padding(.top,20)
                        
                        
                    
                    
                    
                }
                .padding(.top,20)
                .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
                .background{
                 
                    CustomCorner(corner: [.topLeft,.topRight], radius: 15)
                        .fill(.white).ignoresSafeArea()
                        
                }
                .offset(y:showContent ? 0 : (size.height / 1.5))
                .zIndex(0)
                
            
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            
            
        }
        .padding(.top,30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            
            HeaderView()
                .opacity(showContent ? 1 : 0)
        }
      
        .background{
         Rectangle()
                .fill(Color("Green").gradient)
                .ignoresSafeArea()
                .opacity(showContent ? 1 : 0)
        }
        .onAppear{
            
            withAnimation(.easeIn(duration: 0.35).delay(0.05)){
                
                showContent = true
            }
        }
    }
    @ViewBuilder
    func HeaderView ()->some View{
     
        Button {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                
                showContent = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.03){
                
                setTabBar()
                withAnimation(.easeOut(duration: 0.35)){
                    
                    showView = false
                }
                
            }
            
        } label: {
            
          Image(systemName: "chevron.left")
                .font(.title3.weight(.bold))
                .foregroundColor(.white)
                
            
        }
        .padding(15)
          .frame(maxWidth: .infinity,alignment: .leading)
         
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
