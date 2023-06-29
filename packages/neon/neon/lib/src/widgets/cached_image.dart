part of '../../neon.dart';

final _cacheManager = DefaultCacheManager();

abstract class NeonCachedImage extends StatefulWidget {
  const NeonCachedImage({
    required this.getImageFile,
    this.isSvgHint = false,
    this.size,
    this.fit,
    this.svgColor,
    this.iconColor,
    super.key,
  });

  final Future<File> Function() getImageFile;
  final bool isSvgHint;

  final Size? size;
  final BoxFit? fit;

  final Color? svgColor;
  final Color? iconColor;

  @override
  State<NeonCachedImage> createState() => _NeonCachedImageState();
}

class _NeonCachedImageState extends State<NeonCachedImage> {
  Future<Uint8List> _readImage() async {
    final file = await widget.getImageFile();
    return file.readAsBytes();
  }

  late Future<Uint8List> _future = _readImage();

  @override
  Widget build(final BuildContext context) => Center(
        child: FutureBuilder<Uint8List>(
          future: _future,
          builder: (final context, final fileSnapshot) {
            if (!fileSnapshot.hasData) {
              return SizedBox(
                width: widget.size?.width,
                child: NeonLinearProgressIndicator(
                  color: widget.iconColor,
                ),
              );
            }

            if (fileSnapshot.hasError) {
              return NeonException(
                fileSnapshot.error,
                onRetry: () {
                  setState(() {
                    // ignore: discarded_futures
                    _future = _readImage();
                  });
                },
                onlyIcon: true,
                iconSize: widget.size?.shortestSide,
                color: widget.iconColor ?? Theme.of(context).colorScheme.error,
              );
            }

            final content = fileSnapshot.requireData;

            try {
              // TODO: Is this safe enough?
              if (widget.isSvgHint || utf8.decode(content).contains('<svg')) {
                return SvgPicture.memory(
                  content,
                  height: widget.size?.height,
                  width: widget.size?.width,
                  fit: widget.fit ?? BoxFit.contain,
                  colorFilter: widget.svgColor != null ? ColorFilter.mode(widget.svgColor!, BlendMode.srcIn) : null,
                );
              }
            } catch (_) {
              // If the data is not UTF-8
            }

            return Image.memory(
              content,
              height: widget.size?.height,
              width: widget.size?.width,
              fit: widget.fit,
              gaplessPlayback: true,
            );
          },
        ),
      );
}
