import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:maintly_app/core/api_service/end_points.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/attachment.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/badge_chip.dart';
import 'package:url_launcher/url_launcher.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({super.key, required this.attachment, this.index = 0});

  final Attachment attachment;
  final int index;

  static const _imageExtensions = {'.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp'};

  bool _isImage() {
    if (attachment.mimeType?.startsWith('image/') == true) return true;
    if (attachment.type?.toLowerCase() == 'image') return true;
    final path = attachment.path?.toLowerCase() ?? '';
    return _imageExtensions.any((ext) => path.endsWith(ext));
  }

  String _buildUrl() {
    final path = attachment.path ?? '';
    if (path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    final sep = path.startsWith('/') ? '' : '/';
    return '${EndPoint.baseUrl}/storage$sep$path';
  }

  Future<void> _openFile() async {
    final url = _buildUrl();
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final uploaderName = attachment.uploader?.name ?? 'Unknown';
    final date = attachment.createdAt;
    final dateStr = date == null ? '' : DateFormat('dd MMM yyyy').format(date);
    final subtitle = [uploaderName, if (dateStr.isNotEmpty) dateStr].join(' · ');
    final typeColor = _typeColor(attachment.type);
    final isImage = _isImage();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_typeIcon(attachment.mimeType), color: typeColor, size: 22),
          ),
          title: Text(
            attachment.fileName ?? 'Untitled File',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: attachment.type != null
              ? BadgeChip(label: attachment.type!, color: typeColor)
              : null,
        ),
        if (isImage && attachment.path != null) _ImagePreview(url: _buildUrl()),
        if (!isImage && attachment.mimeType != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              attachment.mimeType!,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ),
        if (attachment.notes != null && attachment.notes!.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              attachment.notes!,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.5),
            ),
          ),
      ],
    );

    return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
          color: theme.cardColor,
          clipBehavior: Clip.antiAlias,
          child: isImage ? content : InkWell(onTap: _openFile, child: content),
        )
        .animate(delay: (index * 50).ms)
        .fadeIn(duration: 350.ms)
        .slideX(begin: .08, curve: Curves.easeOutCubic);
  }

  Color _typeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'image':
        return Colors.indigo;
      case 'document':
        return Colors.blue;
      case 'video':
        return Colors.deepPurple;
      case 'audio':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _typeIcon(String? mimeType) {
    if (mimeType == null) return Icons.attach_file_rounded;
    if (mimeType.startsWith('image/')) return Icons.image_outlined;
    if (mimeType.startsWith('video/')) return Icons.videocam_outlined;
    if (mimeType.startsWith('audio/')) return Icons.audiotrack_outlined;
    if (mimeType.contains('pdf')) return Icons.picture_as_pdf_outlined;
    if (mimeType.contains('word') || mimeType.contains('document'))
      return Icons.description_outlined;
    if (mimeType.contains('sheet') || mimeType.contains('excel')) return Icons.table_chart_outlined;
    return Icons.insert_drive_file_outlined;
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: double.infinity,
      height: 180,
      fit: BoxFit.cover,
      placeholder: (_, __) =>
          const SizedBox(height: 180, child: Center(child: CircularProgressIndicator())),
      errorWidget: (_, __, ___) => const SizedBox(
        height: 80,
        child: Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
      ),
    );
  }
}
