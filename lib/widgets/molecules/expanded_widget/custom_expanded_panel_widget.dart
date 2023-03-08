// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Thanks to Brayan Nieves for added this widget to synkron app

import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

// import 'constants.dart';
// import 'expand_icon.dart';
// import 'ink_well.dart';
// import 'material_localizations.dart';
// import 'mergeable_material.dart';
// import 'shadows.dart';
// import 'theme.dart';

const double _kPanelHeaderCollapsedHeight = kMinInteractiveDimension;
const EdgeInsets _kPanelHeaderExpandedDefaultPadding = EdgeInsets.symmetric(
  vertical: 64.0 - _kPanelHeaderCollapsedHeight,
);

class _SaltedKey<S, V> extends LocalKey {
  const _SaltedKey(this.salt, this.value);

  final S salt;
  final V value;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _SaltedKey<S, V> &&
        other.salt == salt &&
        other.value == value;
  }

  @override
  int get hashCode => hashValues(runtimeType, salt, value);

  @override
  String toString() {
    final String saltString = S == String ? "<'$salt'>" : '<$salt>';
    final String valueString = V == String ? "<'$value'>" : '<$value>';
    return '[$saltString $valueString]';
  }
}

/// Signature for the callback that's called when an [CustomExpansionPanel] is
/// expanded or collapsed.
///
/// The position of the panel within an [CustomExpansionPanelList] is given by
/// [panelIndex].
typedef ExpansionPanelCallback = void Function(int panelIndex, bool isExpanded);

/// Signature for the callback that's called when the header of the
/// [CustomExpansionPanel] needs to rebuild.
typedef ExpansionPanelHeaderBuilder = Widget Function(
    BuildContext context, bool isExpanded);

/// A material expansion panel. It has a header and a body and can be either
/// expanded or collapsed. The body of the panel is only visible when it is
/// expanded.
///
/// Expansion panels are only intended to be used as children for
/// [CustomExpansionPanelList].
///
/// See [CustomExpansionPanelList] for a sample implementation.
///
/// See also:
///
///  * [CustomExpansionPanelList]
///  * <https://material.io/design/components/lists.html#types>
class CustomExpansionPanel {
  /// Creates an expansion panel to be used as a child for [CustomExpansionPanelList].
  /// See [CustomExpansionPanelList] for an example on how to use this widget.
  ///
  /// The [headerBuilder], [body], and [isExpanded] arguments must not be null.
  CustomExpansionPanel({
    required this.headerBuilder,
    required this.body,
    this.isExpanded = false,
    this.canTapOnHeader = false,
    this.backgroundColor,
  });

  /// The widget builder that builds the expansion panels' header.
  final ExpansionPanelHeaderBuilder headerBuilder;

  /// The body of the expansion panel that's displayed below the header.
  ///
  /// This widget is visible only when the panel is expanded.
  final Widget body;

  /// Whether the panel is expanded.
  ///
  /// Defaults to false.
  final bool isExpanded;

  /// Whether tapping on the panel's header will expand/collapse it.
  ///
  /// Defaults to false.
  final bool canTapOnHeader;

  /// Defines the background color of the panel.
  ///
  /// Defaults to [ThemeData.cardColor].
  final Color? backgroundColor;
}

/// An expansion panel that allows for radio-like functionality.
/// This means that at any given time, at most, one [ExpansionPanelRadio]
/// can remain expanded.
///
/// A unique identifier [value] must be assigned to each panel.
/// This identifier allows the [CustomExpansionPanelList] to determine
/// which [ExpansionPanelRadio] instance should be expanded.
///
/// See [CustomExpansionPanelList.radio] for a sample implementation.
class ExpansionPanelRadio extends CustomExpansionPanel {
  /// An expansion panel that allows for radio functionality.
  ///
  /// A unique [value] must be passed into the constructor. The
  /// [headerBuilder], [body], [value] must not be null.
  ExpansionPanelRadio({
    required this.value,
    required ExpansionPanelHeaderBuilder headerBuilder,
    required Widget body,
    bool canTapOnHeader = false,
    Color? backgroundColor,
  }) : super(
          body: body,
          headerBuilder: headerBuilder,
          canTapOnHeader: canTapOnHeader,
          backgroundColor: backgroundColor,
        );

  /// The value that uniquely identifies a radio panel so that the currently
  /// selected radio panel can be identified.
  final Object value;
}

/// A material expansion panel list that lays out its children and animates
/// expansions.
///
/// Note that [expansionCallback] behaves differently for [CustomExpansionPanelList]
/// and [CustomExpansionPanelList.radio].
///
/// {@tool dartpad}
/// Here is a simple example of how to implement CustomExpansionPanelList.
///
/// ** See code in examples/api/lib/material/expansion_panel/expansion_panel_list.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [CustomExpansionPanel]
///  * [CustomExpansionPanelList.radio]
///  * <https://material.io/design/components/lists.html#types>
class CustomExpansionPanelList extends StatefulWidget {
  /// Creates an expansion panel list widget. The [expansionCallback] is
  /// triggered when an expansion panel expand/collapse button is pushed.
  ///
  /// The [children] and [animationDuration] arguments must not be null.
  const CustomExpansionPanelList({
    Key? key,
    this.children = const <CustomExpansionPanel>[],
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.expandedHeaderPadding = _kPanelHeaderExpandedDefaultPadding,
    this.dividerColor,
    this.elevation = 0,
  })  : _allowOnlyOnePanelOpen = false,
        initialOpenPanelValue = null,
        super(key: key);

  /// Creates a radio expansion panel list widget.
  ///
  /// This widget allows for at most one panel in the list to be open.
  /// The expansion panel callback is triggered when an expansion panel
  /// expand/collapse button is pushed. The [children] and [animationDuration]
  /// arguments must not be null. The [children] objects must be instances
  /// of [ExpansionPanelRadio].
  ///
  /// {@tool dartpad}
  /// Here is a simple example of how to implement CustomExpansionPanelList.radio.
  ///
  /// ** See code in examples/api/lib/material/expansion_panel/expansion_panel_list.expansion_panel_list_radio.0.dart **
  /// {@end-tool}
  const CustomExpansionPanelList.radio({
    Key? key,
    this.children = const <ExpansionPanelRadio>[],
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.initialOpenPanelValue,
    this.expandedHeaderPadding = _kPanelHeaderExpandedDefaultPadding,
    this.dividerColor,
    this.elevation = 2,
  })  : _allowOnlyOnePanelOpen = true,
        super(key: key);

  /// The children of the expansion panel list. They are laid out in a similar
  /// fashion to [ListBody].
  final List<CustomExpansionPanel> children;

  /// The callback that gets called whenever one of the expand/collapse buttons
  /// is pressed. The arguments passed to the callback are the index of the
  /// pressed panel and whether the panel is currently expanded or not.
  ///
  /// If CustomExpansionPanelList.radio is used, the callback may be called a
  /// second time if a different panel was previously open. The arguments
  /// passed to the second callback are the index of the panel that will close
  /// and false, marking that it will be closed.
  ///
  /// For CustomExpansionPanelList, the callback needs to setState when it's notified
  /// about the closing/opening panel. On the other hand, the callback for
  /// CustomExpansionPanelList.radio is simply meant to inform the parent widget of
  /// changes, as the radio panels' open/close states are managed internally.
  ///
  /// This callback is useful in order to keep track of the expanded/collapsed
  /// panels in a parent widget that may need to react to these changes.
  final ExpansionPanelCallback? expansionCallback;

  /// The duration of the expansion animation.
  final Duration animationDuration;

  // Whether multiple panels can be open simultaneously
  final bool _allowOnlyOnePanelOpen;

  /// The value of the panel that initially begins open. (This value is
  /// only used when initializing with the [CustomExpansionPanelList.radio]
  /// constructor.)
  final Object? initialOpenPanelValue;

  /// The padding that surrounds the panel header when expanded.
  ///
  /// By default, 16px of space is added to the header vertically (above and below)
  /// during expansion.
  final EdgeInsets expandedHeaderPadding;

  /// Defines color for the divider when [CustomExpansionPanel.isExpanded] is false.
  ///
  /// If `dividerColor` is null, then [DividerThemeData.color] is used. If that
  /// is null, then [ThemeData.dividerColor] is used.
  final Color? dividerColor;

  /// Defines elevation for the [CustomExpansionPanel] while it's expanded.
  ///
  /// By default, the value of elevation is 2.
  final double elevation;

  @override
  State<StatefulWidget> createState() => _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  ExpansionPanelRadio? _currentOpenPanel;

  get backgroundColor => null;

  @override
  void initState() {
    super.initState();
    if (widget._allowOnlyOnePanelOpen) {
      assert(_allIdentifiersUnique(),
          'All ExpansionPanelRadio identifier values must be unique.');
      if (widget.initialOpenPanelValue != null) {
        _currentOpenPanel = searchPanelByValue(
            widget.children.cast<ExpansionPanelRadio>(),
            widget.initialOpenPanelValue);
      }
    }
  }

  @override
  void didUpdateWidget(CustomExpansionPanelList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget._allowOnlyOnePanelOpen) {
      assert(_allIdentifiersUnique(),
          'All ExpansionPanelRadio identifier values must be unique.');
      // If the previous widget was non-radio CustomExpansionPanelList, initialize the
      // open panel to widget.initialOpenPanelValue
      if (!oldWidget._allowOnlyOnePanelOpen) {
        _currentOpenPanel = searchPanelByValue(
            widget.children.cast<ExpansionPanelRadio>(),
            widget.initialOpenPanelValue);
      }
    } else {
      _currentOpenPanel = null;
    }
  }

  bool _allIdentifiersUnique() {
    final Map<Object, bool> identifierMap = <Object, bool>{};
    for (final ExpansionPanelRadio child
        in widget.children.cast<ExpansionPanelRadio>()) {
      identifierMap[child.value] = true;
    }
    return identifierMap.length == widget.children.length;
  }

  bool _isChildExpanded(int index) {
    if (widget._allowOnlyOnePanelOpen) {
      final ExpansionPanelRadio radioWidget =
          widget.children[index] as ExpansionPanelRadio;
      return _currentOpenPanel?.value == radioWidget.value;
    }
    return widget.children[index].isExpanded;
  }

  void _handlePressed(bool isExpanded, int index) {
    widget.expansionCallback?.call(index, isExpanded);

    if (widget._allowOnlyOnePanelOpen) {
      final ExpansionPanelRadio pressedChild =
          widget.children[index] as ExpansionPanelRadio;

      // If another ExpansionPanelRadio was already open, apply its
      // expansionCallback (if any) to false, because it's closing.
      for (int childIndex = 0;
          childIndex < widget.children.length;
          childIndex += 1) {
        final ExpansionPanelRadio child =
            widget.children[childIndex] as ExpansionPanelRadio;
        if (widget.expansionCallback != null &&
            childIndex != index &&
            child.value == _currentOpenPanel?.value) {
          widget.expansionCallback!(childIndex, false);
        }
      }

      setState(() {
        _currentOpenPanel = isExpanded ? null : pressedChild;
      });
    }
  }

  ExpansionPanelRadio? searchPanelByValue(
      List<ExpansionPanelRadio> panels, Object? value) {
    for (final ExpansionPanelRadio panel in panels) {
      if (panel.value == value) return panel;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(
      kElevationToShadow.containsKey(widget.elevation),
      'Invalid value for elevation. See the kElevationToShadow constant for'
      ' possible elevation values.',
    );

    final List<MergeableMaterialItem> items = <MergeableMaterialItem>[];

    for (int index = 0; index < widget.children.length; index += 1) {
      if (_isChildExpanded(index) &&
          index != 0 &&
          !_isChildExpanded(index - 1)) {
        items.add(MaterialGap(
            key: _SaltedKey<BuildContext, int>(context, index * 2 - 1)));
      }

      final CustomExpansionPanel child = widget.children[index];
      final Widget headerWidget = child.headerBuilder(
        context,
        _isChildExpanded(index),
      );

      Widget expandIconContainer = Container(
        margin: const EdgeInsetsDirectional.only(end: 8.0),
        child: ExpandIcon(
          disabledColor: ColorsTheme.accentBlue2,
          isExpanded: _isChildExpanded(index),
          padding: const EdgeInsets.all(16.0),
          onPressed: !child.canTapOnHeader
              ? (bool isExpanded) => _handlePressed(isExpanded, index)
              : null,
        ),
      );
      if (!child.canTapOnHeader) {
        final MaterialLocalizations localizations =
            MaterialLocalizations.of(context);
        expandIconContainer = Semantics(
          label: _isChildExpanded(index)
              ? localizations.expandedIconTapHint
              : localizations.collapsedIconTapHint,
          container: true,
          child: expandIconContainer,
        );
      }
      Widget header = SizedBox(
        height: 69,
        //color: Colors.blue,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: const BoxDecoration(
              color: ColorsTheme.accentBlue1,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: AnimatedContainer(
                  //color: Colors.red,
                  duration: widget.animationDuration,
                  curve: Curves.fastOutSlowIn,
                  // margin: _isChildExpanded(index)
                  //     ? widget.expandedHeaderPadding
                  //     : EdgeInsets.zero,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        minHeight: _kPanelHeaderCollapsedHeight),
                    child: headerWidget,
                  ),
                ),
              ),
              expandIconContainer,
            ],
          ),
        ),
      );
      if (child.canTapOnHeader) {
        header = MergeSemantics(
          child: InkWell(
            onTap: () => _handlePressed(_isChildExpanded(index), index),
            child: header,
          ),
        );
      }
      items.add(
        MaterialSlice(
          key: _SaltedKey<BuildContext, int>(context, index * 2),
          color: child.backgroundColor,
          child: Column(
            children: <Widget>[
              header,
              AnimatedCrossFade(
                firstChild: Container(height: 0.0),
                secondChild: child.body,
                firstCurve:
                    const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve:
                    const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: _isChildExpanded(index)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: widget.animationDuration,
              ),
            ],
          ),
        ),
      );

      if (_isChildExpanded(index) && index != widget.children.length - 1) {
        items.add(MaterialGap(
            key: _SaltedKey<BuildContext, int>(context, index * 2 + 1)));
      }
    }

    return MergeableMaterial(
      hasDividers: false,
      dividerColor: widget.dividerColor,
      elevation: widget.elevation,
      children: items,
    );
  }
}
