import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconfinder/model/icon.dart';
import 'package:iconfinder/view_model/search_notifier.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class IconScreen extends StatefulWidget {
  final IconModel icon;
  IconScreen({this.icon});

  @override
  _IconScreenState createState() => _IconScreenState();
}

class _IconScreenState extends State<IconScreen> {
  bool isRasterSizes = true;
  List<bool> selectedType = [true, false];
  int selectedSize;
  SearchNotifier searchNotifier;
  @override
  void initState() {
    super.initState();
    searchNotifier = Provider.of<SearchNotifier>(context, listen: false);
    searchNotifier.addListener(_addListiner);
    selectedSize = widget.icon.rasterSizes.first.size;
  }

  _addListiner() {
    if (searchNotifier.message != '') {
      Toast.show(searchNotifier.message, context);
      searchNotifier.message = '';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchNotifier.removeListener(_addListiner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Icon Details'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            _renderCategories(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.icon.rasterSizes.last.formats.first.previewUrl,
                placeholder: (_, __) {
                  return LinearProgressIndicator();
                },
                errorWidget: (_, __, ___) {
                  return Center(
                    child: Text(
                      'Could\'nt able to load image',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                height: 256,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            _renderTags(),
            SizedBox(
              height: 8,
            ),
            _renderToggleButton(),
            if (isRasterSizes) ...{
              SizedBox(
                height: 16,
              ),
            },
            _renderSizes(),
            SizedBox(
              height: 16,
            ),
            _renderTextDetials(),
            SizedBox(
              height: 32,
            ),
            _renderDownloadButton(),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderTags() {
    return Container(
      height: (widget?.icon?.tags?.isNotEmpty ?? false) ? 48 : 0,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget?.icon?.tags?.length ?? 0,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (_, index) => Chip(
          label: Text(widget.icon.tags[index]),
        ),
      ),
    );
  }

  Widget _renderSizes() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: isRasterSizes
          ? Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget?.icon?.rasterSizes?.length ?? 0,
                  separatorBuilder: (_, __) => SizedBox(width: 8),
                  itemBuilder: (_, index) {
                    bool isSelected =
                        selectedSize == widget.icon.rasterSizes[index].size;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedSize = widget.icon.rasterSizes[index].size;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.icon.rasterSizes[index].size.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
            )
          : Container(),
    );
  }

  Widget _renderTextDetials() {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: isRasterSizes
            ? Text(
                'The PNG format is widely supported and works best with presentations and web design. As it is not a vector format, it\'s not suitable for enlarging after download or for print usage.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              )
            : Text(
                'The SVG format is a vector format that is editable and widely supported by design software and web browsers. SVG can be scaled to any size without loss in quality, which also makes it suitable for print.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  Widget _renderToggleButton() {
    return Center(
      child: ToggleButtons(
        selectedColor: Colors.white,
        color: Colors.black,
        borderColor: Colors.grey,
        selectedBorderColor: Colors.black,
        fillColor: Colors.black,
        children: [
          Container(
            height: 48,
            alignment: Alignment.center,
            child: Text(
              widget.icon.rasterSizes.last.formats.last.format.toUpperCase(),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.center,
            child: Text(
              widget.icon.vectorSizes.last.formats.last.format.toUpperCase(),
            ),
          ),
        ],
        isSelected: selectedType,
        onPressed: (index) {
          setState(() {
            if (index == 0) {
              selectedType[0] = true;
              selectedType[1] = false;
              isRasterSizes = true;
            } else {
              selectedType[0] = false;
              selectedType[1] = true;
              isRasterSizes = false;
            }
          });
        },
      ),
    );
  }

  Widget _renderDownloadButton() {
    return InkWell(
      onTap: () {
        searchNotifier.downloadIcon(
            widget.icon.rasterSizes.last.formats.first.previewUrl,
            widget.icon.iconId.toString());
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(widget?.icon?.isPremium ?? false) ? '👑  ' : ''}Download Icon  (${widget?.icon?.prices?.first?.currency ?? ''} ${(widget?.icon?.isPremium ?? false) ? widget?.icon?.prices?.first?.price ?? 'FREE ' : 'FREE '})',
              style: TextStyle(color: Colors.white),
            ),
            Icon(Icons.download_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _renderCategories() {
    return Container(
      height: (widget?.icon?.categories?.isNotEmpty ?? false) ? 48 : 0,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget?.icon?.categories?.length ?? 0,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (_, index) => Text(
          widget.icon.categories[index].name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
