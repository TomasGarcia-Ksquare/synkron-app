import 'package:flutter/material.dart';
import 'package:synkron_app/providers/employee/employee_provider.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/slivers/custom2_sliver_grid.dart';
import 'package:synkron_app/widgets/atoms/slivers/sliver_sizedbox.dart';
import 'package:synkron_app/widgets/atoms/slivers/sliver_text.dart';
import 'package:synkron_app/widgets/molecules/cards/timeoff_balance_card_selector.dart';

import '../../../providers/employee/time_off/employee_timeoff_records_provider.dart';
import '../../../widgets/atoms/calendar_picker/calendar_picker_date_range.dart';
import '../../../widgets/atoms/slivers/custom_sliver_list.dart';

import '../../../widgets/atoms/slivers/sliver_loading.dart';
import '../../../widgets/molecules/button_filter/row_button_filter.dart';
import '../../../widgets/molecules/modal/custom_bottom_modal.dart';
import '../../../widgets/molecules/modal/modal_canva_widget.dart';
import '../../../widgets/organism/model_filter_timeoff/modal_filter_sort_widget.dart';
import '../../../widgets/organism/model_filter_timeoff/modal_filter_widget.dart';
import '../../../widgets/organism/timeoff_widgets/timeoff_records_employee.dart';

class TimeOffScreen extends StatefulWidget {
  BuildContext navContext;
  TimeOffScreen({
    super.key,
    required this.navContext,
  });

  @override
  State<TimeOffScreen> createState() => _TimeOffScreenState();
}

class _TimeOffScreenState extends State<TimeOffScreen> {
  final _controller = ScrollController();
  var timesOffEmployeeProvider = TimeOffRecordsEmployeeProvider();
  var pageOffset = 0;
  List<DateTime?>? resultsDateRange;

  @override
  void initState() {
    timesOffEmployeeProvider.endReachedAux = true;
    super.initState();

    timesOffEmployeeProvider
        .getTimeOffRecords(timesOffEmployeeProvider.pageOffset, employee: true)
        .then((value) => timesOffEmployeeProvider
            .getBenefits()
            .then((value) => timesOffEmployeeProvider.eventUpdate()));

    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0.0;
        if (!isTop) {
          setState(() {
            timesOffEmployeeProvider.pageOffset++;
            timesOffEmployeeProvider
                .getTimeOffRecords(timesOffEmployeeProvider.pageOffset,
                    employee: true)
                .then((value) {
              if (timesOffEmployeeProvider.isLastPage) {
                if (timesOffEmployeeProvider.endReachedAux) {
                  setState(() {
                    timesOffEmployeeProvider.endReachedAux = false;
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            const SliverSizedBox(height: 16.0),
            SliverText(
                text: "Time Off Balance",
                style: TypographyTheme.fontH2AccentBlue2),
            const SliverSizedBox(height: 24.0),
            Custom2SliverGrid(
                sliverChildDelegate: SliverChildBuilderDelegate(
                    childCount: EmployeeProvider.timeOff.length,
                    (context, index) {
              return TimeOffBalanceCardSelector(
                timeoff: EmployeeProvider.timeOff[index],
              );
            })),
            const SliverSizedBox(height: 48.0),
            SliverToBoxAdapter(
              child: RowButtonExpandedFilter(
                text: "Time Off Records",
                style: TypographyTheme.fontH2AccentBlue2,
                onPressedFilterAlt: () async {
                  CustomBottomModal()
                      .customShowModalBottomSheet(
                    widget.navContext,
                    ModalCanvaWidget(
                      widget: TimeOffFilterWidget(
                        providerTimeOffRecords: timesOffEmployeeProvider,
                      ),
                    ),
                  )
                      .then((value) {
                    timesOffEmployeeProvider.inverseUpdateOptionsValues();

                    setState(() {});
                  });
                },
                onPressedToday: () async {
                  resultsDateRange = await CalendarPickerDateRange()
                          .showDateRangeDialog(
                              context, width, height, resultsDateRange) ??
                      resultsDateRange;

                  if (resultsDateRange != null) {
                    if (resultsDateRange!.length == 1) {
                      var date = resultsDateRange![0];

                      var startDate =
                          DateTime(date!.year, date.month, date.day);
                      var endDate = DateTime(date.year, date.month, date.day);

                      timesOffEmployeeProvider.isValidTheDateRange = true;
                      timesOffEmployeeProvider.startDate =
                          convertDate(startDate.toString());
                      timesOffEmployeeProvider.endDate =
                          convertDate(endDate.toString());

                      timesOffEmployeeProvider.pageOffset = 0;
                      timesOffEmployeeProvider.resetTimeOffRequest();

                      setState(() {
                        timesOffEmployeeProvider
                            .getTimeOffRecords(
                                timesOffEmployeeProvider.pageOffset,
                                employee: true)
                            .then((value) {
                          setState(() {});
                        });
                      });
                    } else if (resultsDateRange!.length == 2) {
                      var start = resultsDateRange![0];
                      var end = resultsDateRange![1];

                      var startDate =
                          DateTime(start!.year, start.month, start.day);
                      var endDate = DateTime(end!.year, end.month, end.day);

                      timesOffEmployeeProvider.isValidTheDateRange = true;
                      timesOffEmployeeProvider.startDate =
                          convertDate(startDate.toString());
                      timesOffEmployeeProvider.endDate =
                          convertDate(endDate.toString());

                      timesOffEmployeeProvider.pageOffset = 0;
                      timesOffEmployeeProvider.resetTimeOffRequest();
                      setState(() {
                        timesOffEmployeeProvider
                            .getTimeOffRecords(
                                timesOffEmployeeProvider.pageOffset,
                                employee: true)
                            .then((value) {
                          setState(() {});
                        });
                      });
                    }
                  } else {}
                },
                conditionalWidget: timesOffEmployeeProvider.isValidTheDateRange
                    ? SizedIconButton(
                        width: 36,
                        onPressed: () {
                          setState(() {
                            resultsDateRange = null;
                            timesOffEmployeeProvider.isValidTheDateRange =
                                false;
                            timesOffEmployeeProvider.pageOffset = 0;
                            timesOffEmployeeProvider.resetTimeOffRequest();
                            timesOffEmployeeProvider.getTimeOffRecords(
                                timesOffEmployeeProvider.pageOffset,
                                employee: true);
                          });
                        },
                      )
                    : const SizedBox(width: 4.0),
                onPressedSort: () async {
                  setState(() {
                    CustomBottomModal()
                        .customShowModalBottomSheet(
                      widget.navContext,
                      ModalCanvaWidget(
                        widget: TimeOffFilterSortWidget(
                          providerTimeOffRecords: timesOffEmployeeProvider,
                        ),
                      ),
                    )
                        .then((value) {
                      timesOffEmployeeProvider.inverseUpdateOptionsValues();
                      setState(() {
                        timesOffEmployeeProvider
                            .getTimeOffRecords(
                                timesOffEmployeeProvider.pageOffset,
                                employee: true)
                            .then((value) {
                          setState(() {});
                        });
                      });
                    });
                  });
                },
              ),
            ),
            const SliverSizedBox(height: 24.0),
            AnimatedBuilder(
              animation: timesOffEmployeeProvider,
              builder: (BuildContext context, Widget? child) {
                return timesOffEmployeeProvider.loadingTimeOffRequests
                    ? const SliverLoading(
                        height: 200,
                      )
                    : timesOffEmployeeProvider.timeOffRequestsList.isEmpty
                        ? const SliverTextHeight(
                            height: 200,
                            text: "No records to see yet",
                            style: TypographyTheme.fontH2)
                        : CustomSliverList(
                            sliverChildDelegate: SliverChildBuilderDelegate(
                                childCount: timesOffEmployeeProvider
                                    .timeOffRequestsList
                                    .length, (context, index) {
                            return TimeOffRecordsEmployee(
                                employee: timesOffEmployeeProvider
                                    .timeOffRequestsList[index]);
                          }));
              },
            ),
            timesOffEmployeeProvider.timeOffRequestsList.isEmpty &&
                    !timesOffEmployeeProvider.loadingTimeOffRequests
                ? const SliverSizedBox(height: 40.0)
                : const SliverSizedBox(height: 12.0),
            timesOffEmployeeProvider.loadingNewTimeOffRequests &&
                    !timesOffEmployeeProvider.loadingTimeOffRequests &&
                    timesOffEmployeeProvider.timeOffRequestsList.isNotEmpty
                ? const SliverLoading(
                    height: 160,
                  )
                : const SliverSizedBox(height: 12.0),
          ],
        ),
      )),
    );
  }

  //---------------------------------------------
  String convertDate(String date) {
    return "${date.replaceAll(" ", "T")}Z";
  }
}
