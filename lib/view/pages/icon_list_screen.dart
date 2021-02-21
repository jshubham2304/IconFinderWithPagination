import 'package:flutter/material.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/model/icon_set.dart';
import 'package:iconfinder/view/pages/icon_screen.dart';
import 'package:iconfinder/view/widget/common_widgets.dart';
import 'package:iconfinder/view_model/icon_notifier.dart';
import 'package:iconfinder/view_model/icon_set_notifier.dart';
import 'package:provider/provider.dart';

class IconListScreen extends StatefulWidget {
  final Iconsets iconset;

  IconListScreen({this.iconset});

  @override
  _IconListScreenState createState() => _IconListScreenState();
}

class _IconListScreenState extends State<IconListScreen> {
  ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  IconNotifier _notifier;

  var count = 1;

  @override
  void initState() {
    super.initState();
    _notifier = Provider.of<IconNotifier>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getIconData());

    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('${widget.iconset.name}'),
        ),
        body: Selector<IconSetNotifier, ResponseStatus>(
          selector: (_, model) => model.status,
          shouldRebuild: (_, __) => true,
          builder: (_, data, __) {
            switch (data) {
              case ResponseStatus.NOINTERNET:
                return noInternet(_getIconData);
                break;
              case ResponseStatus.ERROR:
                return errorWidget(_getIconData);
                break;
              case ResponseStatus.PROCESSING:
                return appLoader(
                  'Wait we\'ll quickly bring your ${widget.iconset.name} icons to you.',
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
                  'Wait we\'ll quickly bring your ${widget.iconset.name} icons to you.',
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
        if (index == _notifier?.iconList?.length ?? 0) {
          if (index >= _notifier.totalCount) {
            return Image(
              image: const AssetImage('assets/images/end.png'),
              height: 100,
            );
          }
          return Center(child: buildProgressIndicator());
        } else {
          // TODO: add icon ui here
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IconScreen(
                    icon: _notifier?.iconList[index],
                  ),
                ),
              );
            },
            child: Text(
              _notifier.iconList[index].iconId.toString(),
            ),
          );
        }
      },
      itemCount: (_notifier?.iconList?.length ?? 0) + 1,
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // TODO: check this count if it is working correct or not
      _notifier.getMoreIconData(widget.iconset.identifier, count);
      count++;
    }
  }

  Future<void> _getIconData() async {
    await _notifier.getIconData(widget.iconset.identifier);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }
}
