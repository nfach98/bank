import 'package:bank/common/constants/color_constants.dart';
import 'package:bank/common/constants/media_query_constants.dart';
import 'package:bank/features/budget/presentation/budget_page.dart';
import 'package:bank/features/main/presentation/bloc/main_bloc.dart';
import 'package:bank/features/dashboard/presentation/dashboard_page.dart';
import 'package:bank/features/main/presentation/widgets/menu_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final Duration dur = const Duration(milliseconds: 200);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  
  late MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: dur);
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(_controller);
    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(_controller);

    _mainBloc = BlocProvider.of<MainBloc>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (_, state) => WillPopScope(
        onWillPop: () async {
          if (!state.isCollapsed) {
            _controller.reverse();
            _mainBloc.add(const ClickMenuEvent(isCollapsed: true));
          }

          return false;
        },
        child: Scaffold(
          backgroundColor: ColorConstants.colorPrimary,
          body: Stack(
            children: [
              SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _menuScaleAnimation,
                  child: MenuList(
                    selectedIndex: state.currentIndex,
                    onMenuItemClicked: (index) {
                      _controller.reverse();
                      _mainBloc.add(const ClickMenuEvent(isCollapsed: true));
                      _mainBloc.add(ChangePageEvent(index: index));
                    },
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: dur,
                top: 0,
                bottom: 0,
                left: state.isCollapsed ? 0 : 0.6 * context.width,
                right: state.isCollapsed ? 0 : -0.4 * context.width,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: GestureDetector(
                    onTap: () {
                      if (!state.isCollapsed) {
                        _controller.reverse();
                        _mainBloc.add(const ClickMenuEvent(isCollapsed: true));
                      }
                    },
                    child: Material(
                      animationDuration: dur,
                      borderRadius: state.isCollapsed
                        ? BorderRadius.zero
                        : BorderRadius.circular(32.0),
                      elevation: 4.0,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          state.currentIndex == 0
                            ? const DashboardPage()
                            : const BudgetPage(),
                          Positioned(
                            top: context.padding.top,
                            child: SizedBox(
                              height: AppBar().preferredSize.height,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: IconButton(
                                  onPressed: () {
                                    if (state.isCollapsed) {
                                      _controller.forward();
                                    } else {
                                      _controller.reverse();
                                    }
                                    _mainBloc.add(ClickMenuEvent(
                                      isCollapsed: !state.isCollapsed
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    color: ColorConstants.colorPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
