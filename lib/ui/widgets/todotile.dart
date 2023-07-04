import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:to_do_list/adaptivity/colours.dart';
import 'package:to_do_list/adaptivity/font_sizes.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/managers/bloc/todo_bloc.dart';

class ToDoTile extends StatelessWidget {
  final ToDo item;

  const ToDoTile(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          context.read<TileListBloc>().add(DeleteTile(tile: item));
        } else {
          context.read<TileListBloc>().add(TappedDone(tile: item));
        }
      },
      key: UniqueKey(),
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: done,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.check,
            color: tileBackLight,
          ),
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 10),
        color: decline,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: tileBackLight,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              context.read<TileListBloc>().add(TappedDone(tile: item));
            },
            icon: item.isDone == true
                ? const Icon(Icons.check_box)
                : item.isDone == false
                    ? const Icon(Icons.check_box_outline_blank)
                    : const Icon(Icons.check_box_outline_blank),
            color: item.isDone == true
                ? done
                : item.isDone == false
                    ? decline
                    : mainText,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      item.importance == 2
                          ? const Text(
                              "!!",
                              style: TextStyle(fontSize: body, color: decline),
                            )
                          : item.importance ==1 ? const Icon(Icons.arrow_downward, color: secondaryText,) : const Text (""),
                      Text(
                              item.task,
                              style: TextStyle(
                                fontSize: body,
                                color: item.isDone == true
                                    ? secondaryText
                                    : mainText,
                                decoration: item.isDone == true
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ],
                  ),
                ),
                item.date != ""
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.date,
                          style: const TextStyle(
                            fontSize: subhead,
                            color: secondaryText,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : const SizedBox(
                        height: 2,
                      ),
              ],
            ),
          ),
          const Icon(
            Icons.info_outline,
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}