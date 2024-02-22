import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/model/task.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<Task> tasks = [];

  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final task = Task(id: "1", title: "Dar comida para o gato", status: false);
    final task1 = Task(id: "2", title: "Comprar arroz", status: false);
    final task2 = Task(id: "3", title: "Comprar carne", status: false);
    final task3 =
        Task(id: "4", title: "Buscar a Juliana na escola", status: false);
    final task4 =
        Task(id: "5", title: "Estudar Tópicos Especiais", status: false);
    final task5 =
        Task(id: "6", title: "Estudar Tópicos Avançados", status: false);
    final task6 = Task(id: "7", title: "Estudar IoT", status: false);
    final task7 = Task(
        id: "8", title: "Estudar Empreendedorismo e Inovação", status: false);
    final task8 =
        Task(id: "9", title: "Estudar Tópicos Especiais", status: false);
    final task9 = Task(id: "10", title: "Estudar Programação", status: false);
    tasks.add(task);
    tasks.add(task1);
    tasks.add(task2);
    tasks.add(task3);
    tasks.add(task4);
    tasks.add(task5);
    tasks.add(task6);
    tasks.add(task7);
    tasks.add(task8);
    tasks.add(task9);
    tasks.add(task5);
    tasks.add(task2);
    tasks.add(task1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "February 2024",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
            icon: const Icon(Icons.date_range),
            style: IconButton.styleFrom(foregroundColor: Colors.white),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDay = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day - 1);
                _focusedDay = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day - 1);
              });
            },
            icon: const Icon(Icons.chevron_left),
            style: IconButton.styleFrom(foregroundColor: Colors.white),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDay = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day + 1);
                _focusedDay = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day + 1);
              });
            },
            icon: const Icon(Icons.chevron_right),
            style: IconButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size(0.0, 80.0),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.week,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerVisible: false,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.white)
            ),
            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(color: Colors.white),
              weekNumberTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                print(_focusedDay);
              });
            },
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.only(top: 15),
            sliver: SliverToBoxAdapter(
              child: Center(
                  child: Text(
                "Minhas tarefas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 60),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  title: Text(tasks[index].title!),
                  trailing: const Icon(Icons.check_box_outline_blank),
                );
              }, childCount: tasks.length),
            ), ///////////
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        height: 40,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            // Add your onPressed code here!
          },
          child: TextButton.icon(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text(
              "Adicionar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0))),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Tarefa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              style: const TextStyle(fontSize: 14.0),
                              controller: _taskController,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Tarefa',
                                contentPadding: const EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Digite uma tarefa';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                onPressed: () {
                                  var taskName = _taskController.text;
                                  var task = Task(id: "1", title: taskName, status: false);
                                  setState(() {
                                    _taskController.clear();
                                    tasks.add(task);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Salvar', style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
            },
          ),
        ),
      ),

      // Here's the new attribute:

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
