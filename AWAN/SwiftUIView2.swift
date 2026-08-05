//
//  SwiftUIView2.swift
//  AWAN
//
//  Created by Tumadhir Alyahya on 21/02/1448 AH.
//

import SwiftUI

struct MedicineView: View {
    var body: some View {

        ZStack {

            // الخلفية
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ZStack {
                // المستطيل السماوي
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(red: 228/255,
                                green: 238/255,
                                blue: 248/255))
                    .frame(height: 140)
                    .padding(3) //يسار يمين
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text("My Medicines")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text("1 of 4 taken today")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        ProgressView(value: 1, total: 4)
                            .progressViewStyle(LinearProgressViewStyle())
                        
                            .frame(height: 6)
                            .background(Color.blue.opacity(0.15))
                            .cornerRadius(3)
                        
                        
                    }
                    
                    Spacer()
                    
                    Image("CALENDER")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                    
                }
                .padding(10)
                
                
                
                
            }
            .padding(.top, -375)   // رفع للادوية
            //////////////////////////////////////// TIMELINE
            
            ZStack {
                
                // الخط
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 2, height: 450)
                
                
                // الدوائر
                VStack(spacing: 95) {
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        )
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 10, height: 10)
                        )

                    
                    Circle()
                        .fill(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .frame(width: 35, height: 35)
                    
                    Circle()
                        .fill(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .frame(width: 35, height: 35)
                }
            }
            .frame(width: 35, height: 450)
            .offset(x: -170, y: 25)
            
            ////////////////////////////////////////////////////
            
            
            
            VStack { // المستطيلات
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        HStack(spacing: 5) {
                            Image(systemName: "clock") //1
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text("8:00 AM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Text("Metformin | 1 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("Taken")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.green)
                        )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            Color(red: 228/255,
                                  green: 238/255,
                                  blue: 248/255)
                        )
                )
                .padding(.leading, 70)
                .padding(.trailing, 20)
                
            }
            .offset(y: -160) //المسافة بين المستطيلات
            
            VStack { // المستطيلات
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        HStack(spacing: 5) {
                            Image(systemName: "clock") //1
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text("10:00 AM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Text("Lisinopril | 1 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("Now")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.blue)
                        )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            Color(red: 228/255,
                                  green: 238/255,
                                  blue: 248/255)
                        )
                )
                .padding(.leading, 70)
                .padding(.trailing, 20)
                
            }
            .offset(y: -40) //المسافة بين المستطيلات
            
            VStack { // المستطيلات
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        HStack(spacing: 5) {
                            Image(systemName: "clock") //3
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text("6:00 PM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Text("Vitamin D | 2 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("Soon")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.orange)
                            
                        )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            Color(red: 228/255,
                                  green: 238/255,
                                  blue: 248/255)
                        )
                )
                .padding(.leading, 70)
                .padding(.trailing, 20)
                
            }
            .offset(y: 80) //المسافة بين المستطيلات
        
            VStack { // المستطيلات
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        
                        HStack(spacing: 5) {
                            Image(systemName: "clock") //4
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text("9:00 PM")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Text("Atorvastatin | 1 pill")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("Later")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color.gray)
                        )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            Color(red: 228/255,
                                  green: 238/255,
                                  blue: 248/255)
                        )
                )
                .padding(.leading, 70)
                .padding(.trailing, 20)
                
            }
            .offset(y: 200) //المسافة بين المستطيلات
        
        
            
            
            // البار اللي تحت
            VStack {
                Spacer()
                
                HStack {
                    
                   
                    VStack(spacing: 5) {
                        Image(systemName: "square.stack.3d.up")
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                        
                        Text("List")
                            .font(.caption)
                            .foregroundColor(.blue)
                            
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                         Image(systemName: "calendar")
                             .font(.system(size: 25))
                             .foregroundColor(.blue)
                         
                         Text("Appointments")
                             .font(.caption)
                             .foregroundColor(.blue)
                             
                     }
                     
                     Spacer()
                     
                     VStack(spacing: 5) {
                         Image(systemName: "pill")
                             .font(.system(size: 25))
                             .foregroundColor(.blue)
                            
                         
                         Text("Medications")
                             .font(.caption)
                             .foregroundColor(.blue)
                         
                         
                             }
                     
                     .padding(.horizontal, 18)
                     .padding(.vertical, 12)
                     .background(
                         RoundedRectangle(cornerRadius: 22)
                             .fill(Color.blue.opacity(0.12))
                     )
                }
                
                
                
                .padding(.horizontal, 40)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 35) // white menu bar
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
                .padding(.horizontal, 4)
                .padding(.bottom, 20)
            }
            }
            
        }
    }


#Preview {
    MedicineView()
}
