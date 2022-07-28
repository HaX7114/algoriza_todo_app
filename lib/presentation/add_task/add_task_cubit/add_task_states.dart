abstract class AddTaskStates {}

class AddTaskInitState extends AddTaskStates {}

class AddTaskChangedDateState extends AddTaskStates {}

class AddTaskChangedStartTimeState extends AddTaskStates {}

class AddTaskChangedEndTimeState extends AddTaskStates {}

//This will happen when a user choose the end time to be before the start time
class AddTaskChangedEndTimeErrorState extends AddTaskStates {}

//This will happen when a user choose the end time to be before the start time
class AddTaskChangedStartTimeErrorState extends AddTaskStates {}

//Repeat state
class AddTaskChangeRepeatState extends AddTaskStates {}

//REminder state
class AddTaskChangeReminderState extends AddTaskStates {}
