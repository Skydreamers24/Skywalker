import 'package:flutter/material.dart';

import 'package:skywalker/misc/sort_option.dart';
import 'package:skywalker/misc/values.dart';
import 'package:skywalker/widgets/other/adaptive.dart';
import 'package:skywalker/widgets/other/custom_divider.dart';

class ListFilter<T> {
  final String name;
  final bool Function(T) test;

  const ListFilter({required this.name, required this.test});
}

class FilteredListView<T> extends StatefulWidget {
  final ListFilter<(String, T)>? searchFilter;
  final List<ListFilter<T>> filters;
  final List<SortOption<T>> sortOptions;
  final List<T> data;
  final ScrollController? scrollController;
  final Widget Function(int, T)? builder;

  const FilteredListView(
      {super.key,
      this.data = const [],
      this.filters = const [],
      this.searchFilter,
      this.builder,
      this.scrollController,
      this.sortOptions = const []});

  @override
  State<FilteredListView<T>> createState() => _FilteredListViewState<T>();
}

class _FilteredListViewState<T> extends State<FilteredListView<T>> {
  ListFilter<T>? selectedFilter;
  SortOption<T>? selectedSortOption;
  List<T> selectedData = const [];

  void changeSelectedFilter(ListFilter<T> filter) {
    setState(() {
      selectedFilter = filter;
      selectedData = widget.data.where(filter.test).toList();
      if (selectedSortOption != null) {
        selectedData.sort(selectedSortOption!.sortFunction);
      }
    });
  }

  void changeSelectedSortOption(SortOption<T> sortOption) {
    setState(() {
      selectedSortOption = sortOption;
      selectedData.sort(selectedSortOption!.sortFunction);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.filters.isNotEmpty) {
      changeSelectedFilter(widget.filters[0]);
    }
    if (widget.sortOptions.isNotEmpty) {
      changeSelectedSortOption(widget.sortOptions[0]);
    }
  }

  @override
  void didUpdateWidget(FilteredListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filters.isNotEmpty) {
      changeSelectedFilter(widget.filters[0]);
    }
    if (widget.sortOptions.isNotEmpty) {
      changeSelectedSortOption(widget.sortOptions[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Adaptive.of(context).dimensions;
    final theme = Theme.of(context);
    final filterChips = [
      for (var filter in widget.filters)
        Padding(
          padding: inline.copyWith(top: 8),
          child: ChoiceChip(
            label: Text(filter.name),
            onSelected: (isSelected) {
              if (isSelected) {
                changeSelectedFilter(filter);
              }
            },
            selected: selectedFilter != null
                ? selectedFilter!.name == filter.name
                : false,
          ),
        ),
    ];
    final searchAndFilterWidget = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: spacious.copyWith(bottom: 8),
            child: SearchAnchor.bar(
              barHintText: "Tap to search",
              barBackgroundColor:
                  WidgetStatePropertyAll(theme.colorScheme.surfaceContainerLow),
              barElevation: const WidgetStatePropertyAll(0),
              suggestionsBuilder: (context, controller) {
                if (widget.builder == null) {
                  return const [];
                }
                var matchingEntries = widget.data;
                if (widget.searchFilter != null) {
                  matchingEntries = widget.data
                      .where((item) =>
                          widget.searchFilter!.test((controller.text, item)))
                      .toList();
                }
                return [
                  for (final (index, dataEntry) in matchingEntries.indexed)
                    widget.builder!(index, dataEntry)
                ];
              },
            ),
          ),
          dimensions.isWide
              ? Padding(
                  padding: comfortable,
                  child: Wrap(
                    children: filterChips,
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                          const SizedBox(
                            width: 7,
                          )
                        ] +
                        filterChips,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 11),
            child: DropdownMenu(
              hintText: "Sort",
              initialSelection: selectedSortOption,
              requestFocusOnTap: false,
              dropdownMenuEntries: [
                for (final sortOption in widget.sortOptions)
                  DropdownMenuEntry(value: sortOption, label: sortOption.name)
              ],
              onSelected: (value) {
                if (value != null) {
                  changeSelectedSortOption(value);
                }
              },
            ),
          )
        ],
      ),
    );
    return Scaffold(
      extendBody: true,
      endDrawer: Drawer(
        backgroundColor: theme.colorScheme.surfaceContainerHigh,
        child: searchAndFilterWidget,
      ),
      endDrawerEnableOpenDragGesture: false,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: ListView.separated(
            controller: widget.scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) => widget.builder != null
                ? widget.builder!(index, selectedData[index])
                : nothing,
            separatorBuilder: (context, index) => const CustomDivider(),
            itemCount: selectedData.length),
      ),
      floatingActionButton: dimensions.isWide
          ? Builder(builder: (context) {
              return FloatingActionButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Icon(Icons.filter_alt),
              );
            })
          : null,
      bottomNavigationBar: dimensions.isWide
          ? null
          : ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: BottomAppBar(
                height: 210,
                padding: comfortableVertical.copyWith(top: 0),
                color: theme.colorScheme.surfaceContainerHighest,
                child: searchAndFilterWidget,
              ),
            ),
    );
  }
}
