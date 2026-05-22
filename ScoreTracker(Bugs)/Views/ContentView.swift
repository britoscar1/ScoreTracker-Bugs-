import SwiftUI


// BUGS INSIDE THIS FILE
// TOTAL: 5 
struct ContentView: View {
    
    @StateObject private var manager = ScoreManager()
    @State private var showingAddStudent = false
    @State private var selectedStudent: StudentModel? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(manager.students) { student in
                    StudentRowView(student: student)
                        .onTapGesture {
                            selectedStudent = student
                        }
                }
                .onDelete { indexSet in
             
                    if let index = indexSet.first {
                        manager.removeStudent(at: index)
                    }
                }
            }
            .navigationTitle("Score Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddStudent = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Top Student") {
                   
                        let top = manager.topStudent()
                        selectedStudent = top
                    }
                }
            }
            .onAppear {
                manager.loadSampleData()
            }
            .sheet(isPresented: $showingAddStudent) {
                AddStudentView(manager: manager)
            }
        }
    }
}

struct StudentRowView: View {
    let student: StudentModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(student.name)
                    .font(.headline)
            
                Text("Average: \(student.average, specifier: "%.1f")%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(student.letterGrade)
                    .font(.title2)
                    .fontWeight(.bold)
                
          
                    .foregroundColor(student.isPasing ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}

struct AddStudentView: View {
    @ObservedObject var manager: ScoreManager
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var scoreInput: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Student Name") {
                    TextField("Name", text: $name)
                }
                Section("Scores (comma separated)") {
                    TextField("e.g. 85, 90, 78", text: $scoreInput)
                }
            }
            .navigationTitle("Add Student")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let scores = scoreInput
                            .split(separator: ",")
                            .compactMap { Double($0.trimmingCharacters(in: .whitespaces)) }
                        let student = Student(name: name, scores: scores)
                        manager.addStudent(student)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
