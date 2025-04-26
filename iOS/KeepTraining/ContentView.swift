//
//  ContentView.swift
//  KeepTraining
//
//  Created by Juan Francisco Bazan Carrizo on 28/01/2025.
//

import SwiftUI
import SwiftData

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//#if os(macOS)
//            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//#endif
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}




//import SwiftUI
//
//struct Training: Identifiable, Codable {
//    let id: UUID
//    var dayOfWeek: String
//    var exercises: [Exercise]
//}
//
//struct Exercise: Identifiable, Codable {
//    let id: UUID
//    var name: String
//    var repetitions: Int
//    var sets: Int
//    var weight: Double
//}
//
//class TrainingViewModel: ObservableObject {
//    @Published var trainings: [Training] = [] {
//        didSet {
//            saveToUserDefaults()
//        }
//    }
//
//    init() {
//        loadFromUserDefaults()
//    }
//
//    func addTraining(_ training: Training) {
//        trainings.append(training)
//    }
//
//    func updateTraining(_ updatedTraining: Training) {
//        if let index = trainings.firstIndex(where: { $0.id == updatedTraining.id }) {
//            trainings[index] = updatedTraining
//        }
//    }
//
//    func deleteTraining(at offsets: IndexSet) {
//        trainings.remove(atOffsets: offsets)
//    }
//
//    private func saveToUserDefaults() {
//        if let data = try? JSONEncoder().encode(trainings) {
//            UserDefaults.standard.set(data, forKey: "trainings")
//        }
//    }
//
//    private func loadFromUserDefaults() {
//        if let data = UserDefaults.standard.data(forKey: "trainings"),
//           let savedTrainings = try? JSONDecoder().decode([Training].self, from: data) {
//            trainings = savedTrainings
//        }
//    }
//}
//
//struct ContentView: View {
//    @StateObject private var viewModel = TrainingViewModel()
//    @State private var isAddingTraining = false
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.trainings) { training in
//                    NavigationLink(destination: TrainingDetailView(training: training)) {
//                        Text(training.dayOfWeek)
//                            .font(.headline)
//                    }
//                }
//                .onDelete(perform: viewModel.deleteTraining)
//            }
//            .navigationTitle("Entrenamientos")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: { isAddingTraining = true }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $isAddingTraining) {
//                AddEditTrainingView(viewModel: viewModel)
//            }
//        }
//    }
//}
//
//struct AddEditTrainingView: View {
//    @Environment(\.dismiss) var dismiss
//    @ObservedObject var viewModel: TrainingViewModel
//    @State private var dayOfWeek = ""
//    @State private var exercises: [Exercise] = []
//    @State private var isEditing = false
//
//    var trainingToEdit: Training?
//
//    init(viewModel: TrainingViewModel, trainingToEdit: Training? = nil) {
//        self.viewModel = viewModel
//        self.trainingToEdit = trainingToEdit
//        if let training = trainingToEdit {
//            _dayOfWeek = State(initialValue: training.dayOfWeek)
//            _exercises = State(initialValue: training.exercises)
//            _isEditing = State(initialValue: true)
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Día de la semana")) {
//                    TextField("Ej: Lunes", text: $dayOfWeek)
//                }
//
//                Section(header: Text("Ejercicios")) {
//                    ForEach(exercises) { exercise in
//                        VStack(alignment: .leading) {
//                            Text(exercise.name)
//                                .font(.headline)
//                            Text("Repeticiones: \(exercise.repetitions), Series: \(exercise.sets), Peso: \(exercise.weight, specifier: "%.1f") kg")
//                                .font(.subheadline)
//                        }
//                    }
//                    .onDelete { offsets in
//                        exercises.remove(atOffsets: offsets)
//                    }
//
//                    Button(action: {
//                        exercises.append(Exercise(id: UUID(), name: "Nuevo Ejercicio", repetitions: 0, sets: 0, weight: 0))
//                    }) {
//                        Label("Agregar Ejercicio", systemImage: "plus.circle")
//                    }
//                }
//            }
//            .navigationTitle(isEditing ? "Editar Entrenamiento" : "Nuevo Entrenamiento")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Cancelar") {
//                        dismiss()
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Guardar") {
//                        let training = Training(id: trainingToEdit?.id ?? UUID(), dayOfWeek: dayOfWeek, exercises: exercises)
//                        if isEditing {
//                            viewModel.updateTraining(training)
//                        } else {
//                            viewModel.addTraining(training)
//                        }
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct TrainingDetailView: View {
//    let training: Training
//
//    var body: some View {
//        Form {
//            Section(header: Text("Día de la semana")) {
//                Text(training.dayOfWeek)
//            }
//
//            Section(header: Text("Ejercicios")) {
//                ForEach(training.exercises) { exercise in
//                    VStack(alignment: .leading) {
//                        Text(exercise.name)
//                            .font(.headline)
//                        Text("Repeticiones: \(exercise.repetitions), Series: \(exercise.sets), Peso: \(exercise.weight, specifier: "%.1f") kg")
//                            .font(.subheadline)
//                    }
//                }
//            }
//        }
//        .navigationTitle("Detalles")
//    }
//}

//@main
//struct TrainingApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}


import SwiftUI

struct Training: Identifiable, Codable {
    let id: UUID
    var date: Date
    var dayOfWeek: String
    var exercises: [Exercise]
}

struct Exercise: Identifiable, Codable {
    let id: UUID
    var name: String
    var repetitions: Int
    var sets: Int
    var weight: Double
}

class TrainingViewModel: ObservableObject {
    @Published var trainings: [Training] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init() {
        loadFromUserDefaults()
    }
    
    func addTraining(_ training: Training) {
        trainings.append(training)
    }
    
    func updateTraining(_ updatedTraining: Training) {
        if let index = trainings.firstIndex(where: { $0.id == updatedTraining.id }) {
            trainings[index] = updatedTraining
        }
    }
    
    func deleteTraining(at offsets: IndexSet) {
        trainings.remove(atOffsets: offsets)
    }
    
    func generateRoutine(for dayOfWeek: String, startingDate: Date) {
        let calendar = Calendar.current
        let exercises = trainings.first(where: { $0.dayOfWeek == dayOfWeek })?.exercises ?? []
        
        for week in 0..<6 {
            if let date = calendar.date(byAdding: .weekOfYear, value: week, to: startingDate) {
                let training = Training(id: UUID(), date: date, dayOfWeek: dayOfWeek, exercises: exercises)
                trainings.append(training)
            }
        }
    }
    
    private func saveToUserDefaults() {
        if let data = try? JSONEncoder().encode(trainings) {
            UserDefaults.standard.set(data, forKey: "trainings")
        }
    }
    
    private func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "trainings"),
           let savedTrainings = try? JSONDecoder().decode([Training].self, from: data) {
            trainings = savedTrainings
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = TrainingViewModel()
    @State private var isAddingTraining = false
    @State private var isGeneratingRoutine = false
    
    @State private var selectedDay = ""
    @State private var startingDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.trainings) { training in
                        NavigationLink(destination: TrainingDetailView(training: training)) {
                            VStack(alignment: .leading) {
                                Text(training.dayOfWeek)
                                    .font(.headline)
                                Text(training.date, style: .date)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTraining)
                }
                Button(action: { isGeneratingRoutine = true }) {
                    Label("Generar rutina por 6 semanas", systemImage: "calendar.badge.plus")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Entrenamientos")
#if os(iOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isAddingTraining = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingTraining) {
                AddEditTrainingView(viewModel: viewModel)
            }
            .sheet(isPresented: $isGeneratingRoutine) {
                GenerateRoutineView(viewModel: viewModel, selectedDay: $selectedDay, startingDate: $startingDate)
            }
#endif
        }
       
    }
}

struct AddEditTrainingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TrainingViewModel
    @State private var date = Date()
    @State private var dayOfWeek = ""
    @State private var exercises: [Exercise] = []
    @State private var isEditing = false
    
    var trainingToEdit: Training?
    
    init(viewModel: TrainingViewModel, trainingToEdit: Training? = nil) {
        self.viewModel = viewModel
        self.trainingToEdit = trainingToEdit
        if let training = trainingToEdit {
            _date = State(initialValue: training.date)
            _dayOfWeek = State(initialValue: training.dayOfWeek)
            _exercises = State(initialValue: training.exercises)
            _isEditing = State(initialValue: true)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Fecha")) {
                    DatePicker("Seleccionar Fecha", selection: $date, displayedComponents: .date)
                        .onChange(of: date) { newValue in
                            dayOfWeek = Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: newValue) - 1]
                        }
                }
                
                Section(header: Text("Día de la semana")) {
                    Text(dayOfWeek.isEmpty ? "Selecciona una fecha" : dayOfWeek)
                        .font(.headline)
                }
                
                Section(header: Text("Ejercicios")) {
                    ForEach(exercises) { exercise in
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                            Text("Repeticiones: \(exercise.repetitions), Series: \(exercise.sets), Peso: \(exercise.weight, specifier: "%.1f") kg")
                                .font(.subheadline)
                        }
                    }
                    .onDelete { offsets in
                        exercises.remove(atOffsets: offsets)
                    }
                    
                    Button(action: {
                        exercises.append(Exercise(id: UUID(), name: "Nuevo Ejercicio", repetitions: 0, sets: 0, weight: 0))
                    }) {
                        Label("Agregar Ejercicio", systemImage: "plus.circle")
                    }
                }
            }
            .navigationTitle(isEditing ? "Editar Entrenamiento" : "Nuevo Entrenamiento")
#if os(iOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let training = Training(id: trainingToEdit?.id ?? UUID(), date: date, dayOfWeek: dayOfWeek, exercises: exercises)
                        if isEditing {
                            viewModel.updateTraining(training)
                        } else {
                            viewModel.addTraining(training)
                        }
                        dismiss()
                    }
                }
            }
#endif
        }
        
    }
}

struct TrainingDetailView: View {
    let training: Training
    
    var body: some View {
        Form {
            Section(header: Text("Fecha")) {
                Text(training.date, style: .date)
            }
            
            Section(header: Text("Día de la semana")) {
                Text(training.dayOfWeek)
            }
            
            Section(header: Text("Ejercicios")) {
                ForEach(training.exercises) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        Text("Repeticiones: \(exercise.repetitions), Series: \(exercise.sets), Peso: \(exercise.weight, specifier: "%.1f") kg")
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("Detalles")
    }
}


struct GenerateRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TrainingViewModel
    @Binding var selectedDay: String
    @Binding var startingDate: Date
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Día base")) {
                    Picker("Día de la semana", selection: $selectedDay) {
                        ForEach(Calendar.current.weekdaySymbols, id: \.self) { day in
                            Text(day).tag(day)
                        }
                    }
                }
                
                Section(header: Text("Fecha inicial")) {
                    DatePicker("Seleccionar fecha", selection: $startingDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Generar rutina")
#if os(iOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Generar") {
                        viewModel.generateRoutine(for: selectedDay, startingDate: startingDate)
                        dismiss()
                    }
                }
            }
#endif
        }
    }
}
