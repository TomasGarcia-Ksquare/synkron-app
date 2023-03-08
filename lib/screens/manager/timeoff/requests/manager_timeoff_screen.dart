import 'package:flutter/material.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/slivers/sliver_sizedbox.dart';
import 'package:synkron_app/widgets/atoms/slivers/sliver_text.dart';

import '../../../../providers/manager/time_off/myteam_timeoff_request_provider.dart';
import '../../../../widgets/atoms/slivers/custom_sliver_list.dart';
import '../../../../widgets/atoms/slivers/sliver_loading.dart';
import '../../../../widgets/molecules/app_bar/custom_app_bar_widget.dart';
import '../../../../widgets/organism/timeoff_widgets/timeoff_records_manager.dart';

class TimeOffManagerScreen extends StatefulWidget {
  BuildContext navContext;
  TimeOffManagerScreen({
    super.key,
    required this.navContext,
  });

  @override
  State<TimeOffManagerScreen> createState() => _TimeOffManagerScreenState();
}

class _TimeOffManagerScreenState extends State<TimeOffManagerScreen> {
  final _controller = ScrollController();
  var timesOffMyTeamProvider = TimeOffRequestsMyTeamProvider();
  var pageOffset = 0;

  @override
  void initState() {
    timesOffMyTeamProvider.endReachedAux = true;
    super.initState();

    timesOffMyTeamProvider.getMyTeamTimeOffRequests(
        timesOffMyTeamProvider.pageOffset,
        employee: true);

    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0.0;
        if (!isTop) {
          setState(() {
            timesOffMyTeamProvider.pageOffset++;
            timesOffMyTeamProvider
                .getMyTeamTimeOffRequests(timesOffMyTeamProvider.pageOffset,
                    employee: true)
                .then((value) {
              if (timesOffMyTeamProvider.isLastPage) {
                if (timesOffMyTeamProvider.endReachedAux) {
                  setState(() {
                    timesOffMyTeamProvider.endReachedAux = false;
                  });
                }
              }
              return null;
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'My Team Time Off',
          textStyle: TypographyTheme.fontH2AccentBlue2),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            const SliverSizedBox(height: 16.0),
            SliverText(
                text: "Time Off Requests",
                style: TypographyTheme.fontH2AccentBlue2),
            const SliverSizedBox(height: 24.0),
            AnimatedBuilder(
              animation: timesOffMyTeamProvider,
              builder: (BuildContext context, Widget? child) {
                return timesOffMyTeamProvider.loadingTimeOffRequests
                    ? const SliverLoading(
                        height: 200,
                      )
                    : timesOffMyTeamProvider.timeOffRequestsList.isEmpty
                        ? const SliverTextHeight(
                            height: 200,
                            text: "No records to see yet",
                            style: TypographyTheme.fontH2)
                        : CustomSliverList(
                            sliverChildDelegate: SliverChildBuilderDelegate(
                                childCount: timesOffMyTeamProvider
                                    .timeOffRequestsList
                                    .length, (context, index) {
                            return TimeOffRecordsMyTeam(
                                myTeam: timesOffMyTeamProvider
                                    .timeOffRequestsList[index],
                                myTeamProvider: timesOffMyTeamProvider);
                          }));
              },
            ),
            timesOffMyTeamProvider.timeOffRequestsList.isEmpty &&
                    !timesOffMyTeamProvider.loadingTimeOffRequests
                ? const SliverSizedBox(height: 40.0)
                : const SliverSizedBox(height: 12.0),
            timesOffMyTeamProvider.loadingNewTimeOffRequests &&
                    !timesOffMyTeamProvider.loadingTimeOffRequests &&
                    timesOffMyTeamProvider.timeOffRequestsList.isNotEmpty
                ? const SliverLoading(
                    height: 160,
                  )
                : const SliverSizedBox(height: 12.0),
          ],
        ),
      )),
    );
  }

  String convertDate(String date) {
    return "${date.replaceAll(" ", "T")}Z";
  }
}
