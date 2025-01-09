import 'package:flutter/material.dart';
import 'package:track_trek/controller/book_track_join_event_controller.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';

class ArrowBackwardIconButton extends StatelessWidget {
  const ArrowBackwardIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(iconCircleWithBorderUrl))),
        child: IconButton(
            highlightColor: BookTrackJoinEventController
                .to.currentIndex.value >
                0
                ? Colors.white10
                : Colors.transparent,
            onPressed: () {
              BookTrackJoinEventController
                  .to.currentIndex.value++;
              BookTrackJoinEventController
                  .to.pageController.value
                  .animateToPage(
                  BookTrackJoinEventController
                      .to.currentIndex.value,
                  duration:
                  const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            },
            icon: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}

class ArrowForwardIconButton extends StatelessWidget {
  const ArrowForwardIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(iconCircleWithBorderUrl))),
        child: IconButton(
            highlightColor: BookTrackJoinEventController
                .to.currentIndex.value >
                0
                ? Colors.white10
                : Colors.transparent,
            onPressed: () {
              if (BookTrackJoinEventController
                  .to.currentIndex.value >
                  0) {
                BookTrackJoinEventController
                    .to.currentIndex.value--;
                BookTrackJoinEventController
                    .to.pageController.value
                    .animateToPage(
                    BookTrackJoinEventController
                        .to.currentIndex.value,
                    duration:
                    const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: BookTrackJoinEventController
                  .to.currentIndex.value >
                  0
                  ? AppColors.normalDarkWhite
                  : null,
            )),
      ),
    );
  }
}