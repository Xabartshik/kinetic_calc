import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/energy_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История расчётов'),
      ),
      /*
      FutureBuilder:
   - FutureBuilder — это виджет, который позволяет строить пользовательский интерфейс на основе состояния Future. Он принимает два основных параметра: future и builder.
   - future: это Future, который вы хотите отслеживать (в вашем случае это context.read<EnergyCubit>().loadCalculations()).
   - builder: это функция, которая принимает контекст и снимок состояния (snapshot) Future, и возвращает виджет в зависимости от состояния.
   - snapshot: это объект, который содержит информацию о текущем состоянии Future: его данные, ошибку, и состояние соединения (например, ожидание, завершение и т.д.).
       */
      body: FutureBuilder<List<String>>(
        future: context.read<EnergyCubit>().loadCalculations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет сохранённых расчётов'));
          }
          //Создаем список, в который будут помещаться карточки с информацией о вычислениях
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(snapshot.data![index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}