import 'package:flutter/material.dart';
import 'package:synkron_app/providers/timesheets/timesheet_approvals_provider.dart';
import 'package:synkron_app/providers/timesheets/timesheet_edithours_provider.dart';
import 'package:synkron_app/providers/timesheets/timesheets_records_provider.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';
import 'package:synkron_app/widgets/organism/time_approvals/time_approvals_widget.dart';
import 'package:synkron_app/providers/timesheets/timesheet_records_my_team_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/widgets/molecules/modal/custom_bottom_modal.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_canva_widget.dart';
import 'package:synkron_app/widgets/molecules/records_card/timesheet_records_widget.dart';
import 'package:synkron_app/widgets/organism/modal_filter/modal_filter_sort_widget.dart';
import 'package:synkron_app/widgets/organism/modal_filter/modal_filter_widget.dart';
import 'package:synkron_app/widgets/atoms/button/custom_filter_button.dart';
import 'package:synkron_app/widgets/atoms/calendar_picker/calendar_picker_date_range.dart';

class MyTeamTimesheet extends StatefulWidget {
  BuildContext navContext;

  MyTeamTimesheet({
    Key? key,
    required this.navContext,
  }) : super(key: key);

  @override
  State<MyTeamTimesheet> createState() => _MyTeamTimesheetState();
}

class _MyTeamTimesheetState extends State<MyTeamTimesheet> {
  final _controller = ScrollController();
  var timesheetBloc = TimesheetsMyTeamProvider();
  var timesheetApprovals = TimesheetApprovalsProvider();
  var editHoursProvider = TimesheetEditHoursProvider();

  List<DateTime?>? resultsDateRange;

  var pageOffset = 0;

  @override
  void initState() {
    timesheetBloc.endReachedAux = true;
    super.initState();

    timesheetApprovals.getTimesheetAppovals(pageOffset, employee: true);
    timesheetBloc
        .getTimesheetRecords(timesheetBloc.pageOffset, employee: true)
        .then((value) => timesheetBloc
            .getProjects()
            .then((value) => timesheetBloc.projectUpdate()));

    // Setup the listener.
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          setState(() {
            timesheetBloc.pageOffset++;
            timesheetBloc
                .getTimesheetRecords(timesheetBloc.pageOffset, employee: true)
                .then((value) {
              if (timesheetBloc.isLastPage) {
                if (timesheetBloc.endReachedAux) {
                  setState(() {
                    timesheetBloc.endReachedAux = false;
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
      appBar: customAppBar(
          title: 'My Team Timesheets',
          textStyle: TypographyTheme.fontH2AccentBlue2),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: width * .025, right: width * .025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * .02),
                      child: Text('Timesheet Approvals',
                          style: TypographyTheme.fontH2AccentBlue2),
                    ),
                    AnimatedBuilder(
                      animation: timesheetApprovals,
                      builder: (BuildContext context, Widget? child) {
                        return timesheetApprovals.loadingTimesheetApprovals
                            ? showLoadingInfoWidget()
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    AnimatedBuilder(
                                      animation: timesheetApprovals,
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return TimeApprovals(
                                          approvalsProvider: timesheetApprovals,
                                          timesheetApprovals: timesheetApprovals
                                              .timesheetApprovals,
                                          editHoursProvider: editHoursProvider,
                                          expansionCallback: (index) {
                                            timesheetApprovals
                                                .expandTimesheetApprovals(
                                                    index);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
              //---------------------------------------------------------------------------------
              //TIMESHEET RECORDS MY TEAM
              //------------------------------------------------------------------------------------------
              SizedBox(
                height: height * .015,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * .04),
                    child: Text('Timesheet Records',
                        style: TypographyTheme.fontH2AccentBlue2),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .03),
                        width: width * .05,
                        child: CustomFilterButton(
                            icon: Icons.filter_alt,
                            iconSize: width * .075,
                            color: ColorsTheme.primaryBlue,
                            padding: const EdgeInsets.all(0),
                            onPressed: () async {
                              CustomBottomModal()
                                  .customShowModalBottomSheet(
                                widget.navContext,
                                ModalCanvaWidget(
                                  widget: TimesheetFilterWidget(
                                    providerTimesheets: timesheetBloc,
                                  ),
                                ),
                              )
                                  .then((value) {
                                if (timesheetBloc.applyFilter) {
                                  setState(() {
                                    timesheetBloc.loadingTimesheetRecords =
                                        true;
                                  });
                                  timesheetBloc
                                      .getTimesheetRecords(
                                          timesheetBloc.pageOffset,
                                          employee: true)
                                      .then((value) {
                                    setState(() {});
                                  });
                                  timesheetBloc.applyFilter = false;
                                }
                                timesheetBloc.inverseUpdateOptionsValues();
                              });
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .03),
                        width: width * .05,
                        child: CustomFilterButton(
                          icon: Icons.today,
                          iconSize: width * .075,
                          color: ColorsTheme.primaryBlue,
                          padding: const EdgeInsets.all(0),
                          onPressed: () async {
                            resultsDateRange = await CalendarPickerDateRange()
                                    .showDateRangeDialog(context, width, height,
                                        resultsDateRange) ??
                                resultsDateRange;

                            if (resultsDateRange != null) {
                              setState(() {
                                timesheetBloc.loadingTimesheetRecords = true;
                              });
                              if (resultsDateRange!.length == 1) {
                                var date = resultsDateRange![0];

                                var startDate = DateTime(
                                    date!.year, date.month, date.day - 6);

                                var endDate = DateTime(
                                    date.year, date.month, date.day + 7);

                                timesheetBloc.isValidTheDateRange = true;
                                timesheetBloc.startDate =
                                    convertDate(startDate.toString());
                                timesheetBloc.endDate =
                                    convertDate(endDate.toString());

                                timesheetBloc.pageOffset = 0;
                                timesheetBloc.resetTimesheetRecord();
                                setState(() {
                                  timesheetBloc
                                      .getTimesheetRecords(
                                          timesheetBloc.pageOffset,
                                          employee: true)
                                      .then((value) {
                                    setState(() {});
                                  });
                                });
                              } else if (resultsDateRange!.length == 2) {
                                var start = resultsDateRange![0];
                                var end = resultsDateRange![1];

                                var startDate = DateTime(
                                    start!.year, start.month, start.day - 6);

                                var endDate =
                                    DateTime(end!.year, end.month, end.day + 7);

                                timesheetBloc.isValidTheDateRange = true;
                                timesheetBloc.startDate =
                                    convertDate(startDate.toString());
                                timesheetBloc.endDate =
                                    convertDate(endDate.toString());

                                timesheetBloc.pageOffset = 0;
                                timesheetBloc.resetTimesheetRecord();
                                setState(() {
                                  timesheetBloc
                                      .getTimesheetRecords(
                                          timesheetBloc.pageOffset,
                                          employee: true)
                                      .then((value) {
                                    setState(() {});
                                  });
                                });
                              }
                            } else {}
                          },
                        ),
                      ),
                      timesheetBloc.isValidTheDateRange
                          ? Container(
                              margin: EdgeInsets.only(right: width * .02),
                              width: width * .05,
                              child: CustomFilterButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    timesheetBloc.loadingTimesheetRecords =
                                        true;
                                  });
                                  setState(() {
                                    resultsDateRange = null;
                                    timesheetBloc.isValidTheDateRange = false;
                                    timesheetBloc.pageOffset = 0;
                                    timesheetBloc.resetTimesheetRecord();
                                    timesheetBloc
                                        .getTimesheetRecords(
                                            timesheetBloc.pageOffset,
                                            employee: true)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  });
                                },
                                icon: Icons.close,
                                color: ColorsTheme.primaryBlue,
                                iconSize: width * .075,
                              ),
                            )
                          : const SizedBox(width: 0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .03),
                        width: width * .05,
                        child: CustomFilterButton(
                          icon: Icons.sort,
                          iconSize: width * .075,
                          color: ColorsTheme.primaryBlue,
                          padding: const EdgeInsets.all(0),
                          onPressed: () async {
                            setState(() {
                              CustomBottomModal()
                                  .customShowModalBottomSheet(
                                widget.navContext,
                                ModalCanvaWidget(
                                  widget: TimesheetFilterSortWidget(
                                    providerTimesheets: timesheetBloc,
                                  ),
                                ),
                              )
                                  .then((value) {
                                if (timesheetBloc.applySort) {
                                  setState(() {
                                    timesheetBloc.loadingTimesheetRecords =
                                        true;
                                  });
                                  timesheetBloc
                                      .getTimesheetRecords(
                                          timesheetBloc.pageOffset,
                                          employee: true)
                                      .then((value) {
                                    setState(() {});
                                  });
                                  timesheetBloc.applySort = false;
                                }
                                timesheetBloc.inverseUpdateOptionsValues();
                              });
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: width * .03,
                      )
                    ],
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: timesheetBloc,
                builder: (BuildContext context, Widget? child) {
                  return timesheetBloc.loadingTimesheetRecords
                      ? showLoadingInfoWidget()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * .01, horizontal: width * .02),
                          child: Column(
                            children: [
                              AnimatedBuilder(
                                animation: timesheetBloc,
                                builder: (BuildContext context, Widget? child) {
                                  return TimesheetRecordWidget(
                                    expansionCallback: (index) {
                                      timesheetBloc
                                          .expandTimesheetRecord(index);
                                    },
                                    timesheetRecord:
                                        timesheetBloc.timesheetRecord,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                },
              ),
              timesheetBloc.timesheetRecord.isEmpty &&
                      !timesheetBloc.loadingTimesheetRecords
                  ? SizedBox(
                      height: height * .50,
                      child: const Center(
                        child: Text(
                          'No Records to see yet',
                          style: TypographyTheme.fontH2,
                        ),
                      ),
                    )
                  : const SizedBox(),
              timesheetBloc.loadingNewTimesheetRecords &&
                      !timesheetBloc.loadingTimesheetRecords &&
                      timesheetBloc.timesheetRecord.isNotEmpty
                  ? SizedBox(
                      height: height * .15,
                      child: showLoadingInfoWidget(),
                    )
                  : SizedBox(
                      height: height * .08,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

String convertDate(String date) {
  return "${date.replaceAll(" ", "T")}Z";
}
