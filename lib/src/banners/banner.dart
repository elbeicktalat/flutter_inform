// Copyright (c) 2022 Talat El Beick. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:inform/src/banners/banner_actions.dart';

const Duration _bannerDisplayDuration = Duration(milliseconds: 4000);
const Duration _bannerTransitionDuration = Duration(milliseconds: 250);
const Curve _bannerHeightCurve = Curves.fastOutSlowIn;

class InformBanner extends StatefulWidget implements MaterialBanner {
  const InformBanner({
    Key? key,
    required this.content,
    this.contentTextStyle,
    List<Widget>? actions,
    this.elevation,
    this.leading,
    this.backgroundColor,
    this.padding,
    this.leadingPadding,
    this.forceActionsBelow = false,
    this.overflowAlignment = OverflowBarAlignment.end,
    this.animation,
    this.onVisible,
    this.divider,
    this.borderRadius,
    this.shadowColor,
    this.onTap,
    this.splashColor,
    this.duration,
    this.border,
    this.margin,
  })  : _actions = actions,
        super(key: key);

  /// The content of the [InformBanner].
  ///
  /// Typically a [Text] widget.
  @override
  final Widget content;

  /// Style for the text in the [content] of the [InformBanner].
  ///
  /// If `null`, [MaterialBannerThemeData.contentTextStyle] is used. If that is
  /// also `null`, [TextTheme.bodyText2] of [ThemeData.textTheme] is used.
  @override
  final TextStyle? contentTextStyle;

  /// The (optional) set of actions that are displayed at the bottom or trailing side of
  /// the [InformBanner].
  ///
  /// Typically this is a list of [TextButton] widgets.
  ///
  /// If this property is not `null`, then the banner is not auto dismissible.
  final List<Widget>? _actions;

  /// The z-coordinate at which to place the material banner.
  ///
  /// This controls the size of the shadow below the material banner.
  ///
  /// Defines the banner's [Material.elevation].
  ///
  /// If this property is null, then [MaterialBannerThemeData.elevation] of
  /// [ThemeData.bannerTheme] is used, if that is also null, the default value is 0.
  ///
  /// If the elevation is 0, the [Scaffold]'s body will be pushed down by the
  /// InformBanner when used with [ScaffoldMessenger],
  /// also you'll be able to add a divider widget at the bottom.
  @override
  final double? elevation;

  /// The (optional) leading widget of the [InformBanner].
  ///
  /// Typically an [Icon] widget.
  @override
  final Widget? leading;

  /// The color of the surface of this [InformBanner].
  ///
  /// If `null`, [MaterialBannerThemeData.backgroundColor] is used. If that's
  /// also `null`, [ColorScheme.surface] of [ThemeData.colorScheme] is used.
  @override
  final Color? backgroundColor;

  /// The amount of space by which to inset the [content].
  ///
  /// If the [actions] are below the [content], this defaults to
  /// `EdgeInsetsDirectional.only(start: 16.0, top: 24.0, end: 16.0, bottom: 4.0)`.
  ///
  /// If the [actions] are trailing the [content], this defaults to
  /// `EdgeInsetsDirectional.only(start: 16.0, top: 2.0)`.
  @override
  final EdgeInsetsGeometry? padding;

  /// The amount of space by which to inset the [leading] widget.
  ///
  /// This defaults to `EdgeInsetsDirectional.only(end: 16.0)`.
  @override
  final EdgeInsetsGeometry? leadingPadding;

  /// An override to force the [actions] to be below the [content] regardless of
  /// how many there are.
  ///
  /// If this is true, the [actions] will be placed below the [content]. If
  /// this is false, the [actions] will be placed on the trailing side of the
  /// [content] if [actions]'s length is 1 and below the [content] if greater
  /// than 1.
  ///
  /// Defaults to false.
  @override
  final bool forceActionsBelow;

  /// The horizontal alignment of the [actions] when the [actions] laid out in a column.
  ///
  /// Defaults to [OverflowBarAlignment.end].
  @override
  final OverflowBarAlignment overflowAlignment;

  /// The animation driving the entrance and exit of the material banner when presented by the [ScaffoldMessenger].
  @override
  final Animation<double>? animation;

  /// Called the first time that the material banner is visible within a [Scaffold] when presented by the [ScaffoldMessenger].
  @override
  final VoidCallback? onVisible;

  /// A callback function, called when ever the material area is taped.
  ///
  /// If this is not `null`, the banner will be non more **auto dismissible**.
  final VoidCallback? onTap;

  /// Defines the bottom divider widget. In order to see it the elevation must be 0.
  ///
  /// Note: don't pass the **height** property, because it's use less.
  /// Also note that's you can't use it if the [elevation] is not null.
  final Divider? divider;

  /// Defines the [borderRadius], by default is null.
  final BorderRadius? borderRadius;

  /// The color that the [Material] widget uses to draw elevation shadows.
  ///
  /// If this property is null, then [ThemeData.shadowColor] is used.
  final Color? shadowColor;

  /// The color of ink splashes.
  ///
  /// If this property is null, then [ThemeData.splashColor] is used.
  final Color? splashColor;

  /// Defines the display duration time. After the duration ends the banner will be auto hided.
  ///
  /// Note: this must be null if banner has an action.
  final Duration? duration;

  /// Defines the border sides around the banner.
  ///
  /// Defaults is null.
  final BoxBorder? border;

  /// Defines the margin of the banner. Margins are the widgets outside spacing.
  ///
  /// If this property is null, then the default value is:
  /// `EdgeInsets.only(bottom: elevation > 0 ? 10.0 : 0.0)`.
  final EdgeInsets? margin;

  /// Defines if the banner has an action. This is needed to define if the banner can be [autoDismissible].
  ///
  /// Actions are any kind of user interaction.
  bool get hasAction => (_actions != null || onTap != null);

  /// Defines if the banner is autoDismissible.
  ///
  /// Banner is autoDismissible, if the banner doesn't [hasAction].
  bool get autoDismissible => hasAction ? false : true;

  /// Never implementing this & never use it. Instead see **_actions** which is the replacement of this.
  /// Explanation of this:
  /// 1) It's here only because we need **InformBanner** to be a subType of **MaterialBanner**.
  /// 2) InformBanner will be dismissible if there is no action.
  @protected
  @override
  List<Widget> get actions => throw 'You must use _actions instead of this.';

  /// Creates an animation controller useful for driving a material banner's entrance and exit animation.
  static AnimationController createAnimationController({
    required TickerProvider vsync,
  }) {
    return AnimationController(
      duration: _bannerTransitionDuration,
      debugLabel: 'InformBanner',
      vsync: vsync,
    );
  }

  /// Creates a copy of this material banner but with the animation replaced with the given animation.
  ///
  /// If the original material banner lacks a key, the newly created material banner will
  /// use the given fallback key.
  @override
  InformBanner withAnimation(
    Animation<double> newAnimation, {
    Key? fallbackKey,
  }) {
    return InformBanner(
      key: key ?? fallbackKey,
      content: content,
      contentTextStyle: contentTextStyle,
      actions: _actions,
      elevation: elevation,
      leading: leading,
      backgroundColor: backgroundColor,
      padding: padding,
      leadingPadding: leadingPadding,
      forceActionsBelow: forceActionsBelow,
      overflowAlignment: overflowAlignment,
      animation: newAnimation,
      onVisible: onVisible,
      divider: divider,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      onTap: onTap,
      splashColor: splashColor,
      duration: duration,
      border: border,
      margin: margin,
    );
  }

  @override
  State<InformBanner> createState() => _InformBannerState();
}

class _InformBannerState extends State<InformBanner> {
  bool _wasVisible = false;

  @override
  void initState() {
    super.initState();
    widget.animation?.addStatusListener(_onAnimationStatusChanged);
    if (widget.autoDismissible) {
      Future.delayed(widget.duration ?? _bannerDisplayDuration, () {
        hideBanner(context);
      });
    }
  }

  @override
  void didUpdateWidget(InformBanner oldWidget) {
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation?.removeStatusListener(_onAnimationStatusChanged);
      widget.animation?.addStatusListener(_onAnimationStatusChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.animation?.removeStatusListener(_onAnimationStatusChanged);
    super.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus animationStatus) {
    switch (animationStatus) {
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        if (widget.onVisible != null && !_wasVisible) {
          widget.onVisible!();
        }
        _wasVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(widget.elevation == null || widget.divider == null);
    assert(widget.borderRadius == null || widget.divider == null);
    assert(widget.onTap == null || widget.duration == null);
    assert(widget._actions == null || widget.duration == null);

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final MaterialBannerThemeData bannerTheme = MaterialBannerTheme.of(context);

    bool isSingleRow = true;
    if (widget._actions != null && widget._actions!.isNotEmpty) {
      isSingleRow = widget._actions!.length == 1 && !widget.forceActionsBelow;
    }

    final EdgeInsetsGeometry padding = widget.padding ??
        bannerTheme.padding ??
        (isSingleRow
            ? const EdgeInsetsDirectional.only(start: 16.0, top: 2.0)
            : const EdgeInsetsDirectional.only(
                start: 16.0,
                top: 24.0,
                end: 16.0,
                bottom: 4.0,
              ));
    final EdgeInsetsGeometry leadingPadding = widget.leadingPadding ??
        bannerTheme.leadingPadding ??
        const EdgeInsetsDirectional.only(end: 16.0);
    final double elevation = widget.elevation ?? bannerTheme.elevation ?? 0.0;
    final Color backgroundColor = widget.backgroundColor ??
        bannerTheme.backgroundColor ??
        theme.colorScheme.surface;
    final TextStyle? textStyle = widget.contentTextStyle ??
        bannerTheme.contentTextStyle ??
        theme.textTheme.bodyText2;
    final Color? shadowColor = widget.shadowColor ?? theme.shadowColor;
    final Color? splashColor = widget.splashColor ?? theme.splashColor;

    Widget buttonBar = Container(
      alignment: AlignmentDirectional.centerEnd,
      constraints: const BoxConstraints(minHeight: 52.0),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OverflowBar(
        overflowAlignment: widget.overflowAlignment,
        spacing: 8,
        children: widget._actions ?? [],
      ),
    );

    Divider? _divider;
    if (widget.divider != null) {
      _divider = Divider(
        height: 0,
        key: widget.divider!.key,
        color: widget.divider!.color,
        thickness: widget.divider!.thickness,
        endIndent: widget.divider!.endIndent,
        indent: widget.divider!.indent,
      );
    }

    Widget banner = Container(
      margin: widget.margin ??
          EdgeInsets.only(
            bottom: elevation > 0 ? 10.0 : 0.0,
          ),
      decoration: BoxDecoration(
        border: widget.border,
      ),
      child: Material(
        color: backgroundColor,
        elevation: elevation,
        shadowColor: shadowColor,
        borderRadius: widget.borderRadius,
        textStyle: widget.contentTextStyle,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: widget.borderRadius,
          splashColor: splashColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: padding,
                child: Row(
                  children: <Widget>[
                    if (widget.leading != null)
                      Padding(
                        padding: leadingPadding,
                        child: widget.leading,
                      ),
                    Expanded(
                      child: DefaultTextStyle(
                        style: textStyle!,
                        child: widget.content,
                      ),
                    ),
                    if (isSingleRow) buttonBar,
                  ],
                ),
              ),
              if (!isSingleRow) buttonBar,
              if (elevation == 0) _divider ?? const Divider(height: 0),
            ],
          ),
        ),
      ),
    );

    // This provides a static banner for backwards compatibility.
    if (widget.animation == null) return banner;

    banner = SafeArea(
      child: banner,
    );

    final CurvedAnimation heightAnimation = CurvedAnimation(
      parent: widget.animation!,
      curve: _bannerHeightCurve,
    );

    final Animation<Offset> slideOutAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget.animation!,
        curve: const Threshold(0.0),
      ),
    );

    banner = Semantics(
      container: true,
      liveRegion: true,
      onDismiss: () {
        ScaffoldMessenger.of(context).removeCurrentMaterialBanner(
          reason: MaterialBannerClosedReason.dismiss,
        );
      },
      child: mediaQueryData.accessibleNavigation
          ? banner
          : SlideTransition(
              position: slideOutAnimation,
              child: banner,
            ),
    );

    final Widget materialBannerTransition;
    if (mediaQueryData.accessibleNavigation) {
      materialBannerTransition = banner;
    } else {
      materialBannerTransition = AnimatedBuilder(
        animation: heightAnimation,
        builder: (BuildContext context, Widget? child) {
          return Align(
            alignment: AlignmentDirectional.bottomStart,
            heightFactor: heightAnimation.value,
            child: child,
          );
        },
        child: banner,
      );
    }

    return Hero(
      tag: '<InformBanner Hero tag - ${widget.content}>',
      child: ClipRect(child: materialBannerTransition),
    );
  }
}
