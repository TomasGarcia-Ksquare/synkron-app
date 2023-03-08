import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/providers/employee/employee_provider.dart';
import 'package:synkron_app/providers/navbar/bottom_navbar_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/atoms/slivers/custom2_sliver_grid.dart';
import 'package:synkron_app/widgets/atoms/slivers/custom_sliver_grid.dart';
import 'package:synkron_app/widgets/atoms/slivers/sliver_sizedbox.dart';
import 'package:synkron_app/widgets/atoms/slivers/sliver_text.dart';
import 'package:synkron_app/widgets/molecules/cards/benefit_description_card.dart';
import 'package:synkron_app/widgets/molecules/cards/timeoff_balance_card_selector.dart';
import 'package:synkron_app/widgets/molecules/user_widgets/user_welcome_header.dart';
import 'package:synkron_app/widgets/organism/user_widgets/user_profile_widget.dart';
import 'package:synkron_app/widgets/organism/user_widgets/user_projects_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.navBarContext});

  final BuildContext? navBarContext;

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);

    return Scaffold(
      backgroundColor: ColorsTheme.white,
      body: SafeArea(
        child: FutureBuilder(
            future: EmployeeProvider().loadUserInfo(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                EmployeeProfileModel user =
                    snapshot.data as EmployeeProfileModel;
                //to know if the user is manager
                bottomNavbarProvider.isManager = user.isManager;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      const SliverSizedBox(height: 16.0),
                      SliverToBoxAdapter(
                          child: UserWelcomeHeader(
                        firstName: user.firstName!,
                        navBarContext: navBarContext,
                      )),
                      SliverToBoxAdapter(child: UserProfileWidget(user: user)),
                      const SliverSizedBox(height: 24.0),
                      SliverToBoxAdapter(
                          child: UserProjectWidget(
                              projects: EmployeeProvider.projects)),
                      const SliverSizedBox(height: 24.0),
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
                      const SliverSizedBox(height: 24.0),
                      SliverText(
                          text: "Benefits",
                          style: TypographyTheme.fontH2AccentBlue2),
                      const SliverSizedBox(height: 15.0),
                      const SliverText(
                          text: "Compensations & Benefits By Law",
                          style: TypographyTheme.fontH3),
                      const SliverSizedBox(height: 20.0),
                      CustomSliverGrid(
                          sliverChildDelegate: SliverChildBuilderDelegate(
                              childCount: EmployeeProvider.benefitsByLaw.length,
                              (context, index) {
                        return BenefitDescriptionCard(
                          benefits: EmployeeProvider.benefitsByLaw[index],
                        );
                      })),
                      const SliverSizedBox(height: 40.0),
                      const SliverText(
                          text: "Additional Benefits",
                          style: TypographyTheme.fontH3),
                      const SliverSizedBox(height: 20.0),
                      CustomSliverGrid(
                          sliverChildDelegate: SliverChildBuilderDelegate(
                              childCount: EmployeeProvider
                                  .benefitsAditional.length, (context, index) {
                        return BenefitDescriptionCard(
                          benefits: EmployeeProvider.benefitsAditional[index],
                        );
                      })),
                      const SliverSizedBox(height: 16.0),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: showLoadingInfoWidget(),
                );
              }
            })),
      ),
    );
  }
}
