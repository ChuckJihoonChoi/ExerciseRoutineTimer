# ExerciseRoutineTimer

An iOS app for managing and tracking exercise routines with workout history.  
This project uses SwiftUI and SwiftData with MVVM architecture.

---

## Features

- Create and manage custom exercise routines -> RoutineView
- Add modules (exercises) with sets, repetitions, and weights -> ModuleView
- Track workout sessions and store history -> WorkoutView
- View the workout session records with chart -> HistoryView
- View workout set details for each exercise module -> HistoryDetailView

---

## Data Models

### Routine
Represents a full workout plan.
- name
- restBetweenModules
- voiceEnabled
- vibrationEnabled
- modules: [Module]

### Module
Represents a single exercise within a Routine.
- name
- sets
- repititions
- weight
- workSeconds
- restSeconds
- note
- routine (relationship)

### RoutineHistory
Stores completed workout session data.
- routineId
- routineName
- totalSeconds
- modules: [ModuleHistory]

### ModuleHistory
Stores executed exercise data during a session.
- moduleName
- executedSets
- executedReps
- executedWeight
- executedWorkSeconds
- executedRestSeconds
- note
- setRecords: [WorkoutSetRecord]

### WorkoutSetRecord
Stores detailed information for each exercise set.
- setIndex
- executedReps
- executedWeight
- executedWorkSeconds
- executedRestSeconds

---

## Technologies

- Swift
- SwiftUI
- SwiftData
- MVVM architecture

---

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/ChuckJihoonChoi/ExerciseRoutineTimer.git
```

2. Open `ExerciseRoutineTimer.xcodeproj` in Xcode.

3. Run the app on an iOS Simulator or a real iPhone.

---

## Contributors

- Jihoon (Developer)
- Nguyet Nga Nguyen (Developer)
- Thuy Minh Luu (Developer)

---
---

## University Project Statement

This repository was created as part of a group assignment for a postgraduate course at the University of Technology Sydney (UTS).  
All group members have reviewed and agreed to publicly share this project under the MIT License for educational and non-commercial purposes.

This project remains the joint intellectual property of the contributing team members.

---

## License

This project is licensed under the MIT License.

---

## Future Roadmap

- [ ] Add HealthKit integration for calorie & heart rate tracking
- [ ] Implement user profiles and goal tracking
- [ ] Add notifications and reminders for workout schedules
- [ ] Improve UI with animations and custom themes
- [ ] Create export and share workout history feature
- [ ] Support iPad and Mac Catalyst versions
