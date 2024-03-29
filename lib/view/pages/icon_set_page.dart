import 'package:flutter/material.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/model/category.dart';
import 'package:iconfinder/view/pages/icon_list_screen.dart';
import 'package:iconfinder/view/widget/Icon_set_card.dart';
import 'package:iconfinder/view/widget/common_widgets.dart';
import 'package:iconfinder/view_model/icon_set_notifier.dart';
import 'package:provider/provider.dart';

class IconSetScreen extends StatefulWidget {
  final Category category;

  IconSetScreen({this.category});

  @override
  _IconSetScreenState createState() => _IconSetScreenState();
}

class _IconSetScreenState extends State<IconSetScreen> {
  ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  IconSetNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = Provider.of<IconSetNotifier>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getIconSetData());

    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('${widget.category.name}'),
        ),
        body: Selector<IconSetNotifier, ResponseStatus>(
          selector: (_, model) => model.status,
          shouldRebuild: (_, __) => true,
          builder: (_, data, __) {
            switch (data) {
              case ResponseStatus.NOINTERNET:
                return noInternet(_getIconSetData);
                break;
              case ResponseStatus.ERROR:
                return errorWidget(_getIconSetData);
                break;
              case ResponseStatus.PROCESSING:
                return appLoader(
                  'Wait we\'ll quickly bring your ${widget.category.name} icons to you.',
                );
                break;
              case ResponseStatus.NOTFOUND:
                return noDataFound();
                break;
              case ResponseStatus.FOUND:
                return _renderListView();
                break;
              default:
                return appLoader(
                  'Wait we\'ll quickly bring your ${widget.category.name} icons to you.',
                );
            }
          },
        ),
      ),
    );
  }

  Widget _renderListView() {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == _notifier?.iconSets?.length ?? 0) {
          if (index >= _notifier.totalCount) {
            return Image(
              image: const AssetImage('assets/images/end.png'),
              height: 100,
            );
          }
          return Center(child: buildProgressIndicator());
        } else {
          return IconSetCard(
            imageUrl: 'https://picsum.photos/id/${100 + index}/600/100?blur',
            name: _notifier.iconSets[index].name +
                '  (${_notifier.iconSets[index].iconsCount})',
            icon: _notifier.iconSets[index],
            onclick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IconListScreen(
                    iconset: _notifier.iconSets[index],
                  ),
                ),
              );
            },
          );
        }
      },
      itemCount: (_notifier?.iconSets?.length ?? 0) + 1,
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _notifier.getMoreIconSetData(
        widget.category.identifier,
        _notifier.iconSets.last,
      );
    }
  }

  Future<void> _getIconSetData() async {
    await _notifier.getIconSetData(widget.category.identifier);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }
}
