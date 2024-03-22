import 'package:flutter/material.dart';
import 'package:flutter_exam_jubo/features/user/data/user.dart';
import 'package:flutter_exam_jubo/utils/datetime_extension.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

enum TileType { info, delete, meals }

class UserTile extends StatefulWidget {
  final TileType tileType;
  final User user;
  final VoidCallback? onDeleteClick;
  final Function(User)? onChange;

  const UserTile({
    super.key,
    required this.user,
    this.tileType = TileType.info,
    this.onDeleteClick,
    this.onChange,
  });

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.tileType) {
      TileType.delete => buildDeleteLayout(),
      TileType.meals => buildMealsLayout(),
      _ => buildInfoLayout(),
    };
  }

  Widget buildInfoLayout() {
    return Builder(builder: (context) {
      return Card(
        color: Colors.grey.shade100,
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.person),
            ),
            const Gap(8),
            Expanded(child: userBasicInfo(widget.user)),
          ],
        ),
      );
    });
  }

  Widget buildDeleteLayout() {
    return Builder(builder: (context) {
      return Card(
        color: Colors.grey.shade100,
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.person),
            ),
            const Gap(8),
            Expanded(
              child: userBasicInfo(widget.user),
            ),
            const Gap(8),
            IconButton(
                onPressed: widget.onDeleteClick,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ))
          ],
        ),
      );
    });
  }

  Widget buildMealsLayout() {
    return Builder(builder: (context) {
      return Card(
        color: Colors.orange.shade50,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  color: Colors.orange,
                  padding: const EdgeInsets.all(16),
                  child: const Icon(Icons.person),
                ),
                const Gap(8),
                Expanded(
                  child: userBasicInfo(widget.user),
                ),
              ],
            ),
            ColoredBox(
              color: Colors.grey.shade50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('供餐'),
                  CheckboxMenuButton(
                    value: widget.user.breakfast,
                    onChanged: (checked) {
                      widget.user.breakfast = checked ?? false;
                      widget.onChange?.call(widget.user);
                    },
                    child: const Text('早餐'),
                  ),
                  CheckboxMenuButton(
                    value: widget.user.lunch,
                    onChanged: (checked) {
                      debugPrint('lunch onChanged: $checked');
                      // setState(() {
                      // });
                      widget.user.lunch = checked ?? false;
                      widget.onChange?.call(widget.user);
                    },
                    child: const Text('午餐'),
                  ),
                  CheckboxMenuButton(
                    value: widget.user.dinner,
                    onChanged: (checked) {
                      debugPrint('dinner onChanged: $checked');
                      // setState(() {
                      // });
                      widget.user.dinner = checked ?? false;
                      widget.onChange?.call(widget.user);
                    },
                    child: const Text('晚餐'),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget userBasicInfo(User user) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name ?? '無',
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          user.birthday == null
              ? const Text('----/--/--')
              : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '生日: ${DateFormat.yMd('zh_TW').format(user.birthDate)}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          '年齡:${user.birthDate.calculateAge}',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
