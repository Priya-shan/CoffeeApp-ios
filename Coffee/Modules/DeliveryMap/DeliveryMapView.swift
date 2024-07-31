//
//  DeliveryMapView.swift
//  Coffee
//
//  Created by Shanmuga Priya M on 02/11/23.
//
import SwiftUI
import ComposableArchitecture
import MapKit
struct DeliveryMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.83834587046632, longitude: 14.254053016537693),
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )

    private let places = [
        PointOfInterest(name: "Galeria Umberto I", latitude: 40.83859036140747, longitude: 14.24945566830365, image: "icon-bike"),
        PointOfInterest(name: "Piazza Dante", latitude: 40.848891382971985, longitude: 14.250055428532933, image: "profile")
    ]

    let store: StoreOf<DeliveryMapFeature>
    @State private var isSheetPresented = true
    @State private var trackingLine: [CLLocationCoordinate2D] = []

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: places) { place in
                MapAnnotation(coordinate: place.coordinate) {
                    Image(place.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }

        }
            .sheet(isPresented: $isSheetPresented) {
                VStack{
                    Spacer()
                    Text("10 minutes left").bold()
                    Text("Delivery to ").foregroundColor(.gray)+Text("Jl. Kpg Sutoyo")
                    ProgressView()
                        .progressViewStyle(.linear)
                        .tint(Color.green)
                        .padding(20)
                    VStack{
                        HStack(){
                            Image("icon-bike")
                                .resizable()
                                .frame(width:50,height:50)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                            Spacer()
                            VStack(alignment: .leading,spacing: 10){
                                Text("Delivered your order").bold()
                                Text("We deliver your goods to you in the shortest time possible")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 220)
                                
                        }
                    }
                    .padding(20)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                    .padding(.horizontal,20)
                    Spacer()
                    HStack(spacing:15){
                        Image("profile-deliveryboy")
                            .resizable()
                            .frame(width: 80,height: 80)
                        VStack(alignment: .leading,spacing: 10){
                            Text("Johan Hawn").bold()
                            Text("Personal Courrier")
                        }
                        Spacer()
                        Image("icon-phone")
                            .resizable()
                            .frame(width: 35,height: 35)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                        
                    }
                    .padding(.horizontal,30)
                    Spacer()
                }
                .presentationDetents([.height(350)])
            }
        }
}

struct PointOfInterest: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let image:String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
#Preview {
    DeliveryMapView(store: Store(initialState: DeliveryMapFeature.State(), reducer: {
        DeliveryMapFeature()
    }))
}
