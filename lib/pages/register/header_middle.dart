part of '../register_page.dart';

class _HeaderMiddle extends StatelessWidget {
  const _HeaderMiddle();

  @override
  Widget build(BuildContext context) {
    final width = getDefaultWidth(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '지금우리',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
                fontSize: width / 12,
              ),
        ),
        Assets.images.heart.image(
          width: width / 8,
        ),
        Text(
          '만나',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
                fontSize: width / 12,
              ),
        ),
      ],
    );
  }
}
