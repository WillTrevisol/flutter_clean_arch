import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:clean_arch/ui/pages/surveys/components/components.dart';
import 'package:clean_arch/ui/components/components.dart';
import 'package:clean_arch/ui/helpers/helpers.dart';
import 'package:clean_arch/ui/mixins/mixins.dart';
import 'package:clean_arch/ui/pages/pages.dart';

class SurveysPage extends StatefulWidget {
  const SurveysPage({super.key, required this.presenter});

  final SurveysPresenter presenter;

  @override
  State<SurveysPage> createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> with LoadingManager, NavigationManager, SessionManager, RouteAware {

  final routeObserver = Get.find<RouteObserver>();

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    widget.presenter.loadData();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    routeObserver.subscribe(this, ModalRoute.of(context) as Route);
    return Scaffold(
      appBar: AppBar(
        title: Text(R.translation.surveys),
      ),
      body: Builder(
        builder: (context) {
          handleLoading(context, widget.presenter.isLoadingStream);
          handleSessionExpired(widget.presenter.sessionExpiredStream);
          handleNavigation(widget.presenter.navigateToPageStream);
          widget.presenter.loadData();

          return StreamBuilder<List<SurveyViewEntity>>(
            stream: widget.presenter.surveysStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadPage(error: snapshot.error.toString(), reload: widget.presenter.loadData);
              }

              if (snapshot.hasData) {
                return Provider(
                  create: (_) => widget.presenter,
                  child: SurveyItems(
                    viewEntities: snapshot.data as List<SurveyViewEntity>,
                  ),
                );
              }

              return const SizedBox(height: 0);
            }
          );
        }
      ),
    );
  }
}
