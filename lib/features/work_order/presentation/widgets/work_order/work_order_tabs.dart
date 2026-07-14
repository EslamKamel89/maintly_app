import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/heleprs/validator.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order/work_order_cubit.dart';
import 'package:maintly_app/features/work_order/services/work_orders_service.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/attachments_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/audit_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/comments_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/general_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/resources_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/scheduling_tab.dart';

const _kTabColors = [
  Color(0xFF4F46E5), // General     – indigo
  Color(0xFF0891B2), // Resources   – cyan
  Color(0xFFEA580C), // Scheduling  – orange
  Color(0xFF7C3AED), // Audit       – violet
  Color(0xFFDB2777), // Attachments – pink
  Color(0xFF16A34A), // Comments    – green
];

const _kTabLabels = [
  'General',
  'Resources',
  'Scheduling',
  'Audit',
  'Attachments',
  'Comments',
];

const _kTabIcons = [
  Icons.info_outline_rounded,
  Icons.build_outlined,
  Icons.calendar_month_outlined,
  Icons.history_rounded,
  Icons.attach_file_rounded,
  Icons.chat_bubble_outline_rounded,
];

class WorkOrderTabs extends StatefulWidget {
  const WorkOrderTabs({
    super.key,
    required this.workOrder,
    required this.isRefreshing,
    required this.onRefresh,
  });

  final WorkOrderDetailed workOrder;
  final bool isRefreshing;
  final Future<void> Function() onRefresh;

  @override
  State<WorkOrderTabs> createState() => _WorkOrderTabsState();
}

class _WorkOrderTabsState extends State<WorkOrderTabs> {
  bool _isOpen = false;

  void _toggle() => setState(() => _isOpen = !_isOpen);
  void _close() {
    if (_isOpen) setState(() => _isOpen = false);
  }

  void _showAttachFilesSheet() {
    final cubit = context.read<WorkOrderCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _AttachFilesSheet(
        workOrderId: widget.workOrder.id!,
        cubit: cubit,
      ),
    );
  }

  void _showAddCommentSheet() {
    final cubit = context.read<WorkOrderCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _AddCommentSheet(
        workOrderId: widget.workOrder.id!,
        cubit: cubit,
      ),
    );
  }

  void _showCompleteSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) => const _CompleteWorkOrderSheet(),
      );

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return DefaultTabController(
      length: _kTabLabels.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.workOrder.title ?? 'Work Order',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(widget.isRefreshing ? 60.0 : 56.0),
            child: _ColoredTabBar(isRefreshing: widget.isRefreshing),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggle,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              _isOpen ? Icons.close : Icons.more_vert,
              key: ValueKey(_isOpen),
            ),
          ),
        ),
        body: Stack(
          children: [
            // layer 0: tab content
            TabBarView(
              children: [
                GeneralTab(workOrder: widget.workOrder, onRefresh: widget.onRefresh),
                ResourcesTab(workOrder: widget.workOrder, onRefresh: widget.onRefresh),
                SchedulingTab(workOrder: widget.workOrder, onRefresh: widget.onRefresh),
                AuditTab(workOrder: widget.workOrder, onRefresh: widget.onRefresh),
                AttachmentsTab(workOrder: widget.workOrder, onRefresh: widget.onRefresh),
                CommentsTab(workOrder: widget.workOrder, onRefresh: widget.onRefresh),
              ],
            ),

            // layer 1: dim overlay
            if (_isOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _close,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.18),
                  ),
                ),
              ),

            // layer 2: action items
            if (_isOpen)
              Positioned(
                right: 16,
                // 16 (FAB bottom) + 56 (FAB height) + 12 (gap)
                bottom: 84,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _ActionMenuItem(
                      icon: Icons.attach_file,
                      label: 'Attach Files',
                      color: primary,
                      onTap: () {
                        _close();
                        _showAttachFilesSheet();
                      },
                      delay: Duration.zero,
                    ),
                    const SizedBox(height: 10),
                    _ActionMenuItem(
                      icon: Icons.chat_bubble_outline,
                      label: 'Add Comment',
                      color: primary,
                      onTap: () {
                        _close();
                        _showAddCommentSheet();
                      },
                      delay: const Duration(milliseconds: 50),
                    ),
                    const SizedBox(height: 10),
                    _ActionMenuItem(
                      icon: Icons.check_circle_outline,
                      label: 'Mark Job as Completed',
                      color: Colors.green,
                      onTap: () {
                        _close();
                        _showCompleteSheet();
                      },
                      delay: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

// ── Colored tab bar ────────────────────────────────────────────────────────

class _ColoredTabBar extends StatelessWidget {
  const _ColoredTabBar({required this.isRefreshing});

  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final selected = controller.index;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isRefreshing) const LinearProgressIndicator(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              child: Row(
                children: List.generate(_kTabLabels.length, (i) {
                  final isSelected = i == selected;
                  final color = _kTabColors[i];

                  return Padding(
                    padding: EdgeInsets.only(right: i < _kTabLabels.length - 1 ? 8 : 0),
                    child: GestureDetector(
                      onTap: () => controller.animateTo(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? color : color.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: isSelected ? color : color.withValues(alpha: 0.50),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _kTabIcons[i],
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _kTabLabels[i],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Action menu item ───────────────────────────────────────────────────────

class _ActionMenuItem extends StatelessWidget {
  const _ActionMenuItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.delay = Duration.zero,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 200.ms)
        .slideY(begin: 0.3, curve: Curves.easeOutCubic);
  }
}

// ── Bottom sheets (stubs) ──────────────────────────────────────────────────

class _AttachFilesSheet extends StatefulWidget {
  const _AttachFilesSheet({required this.workOrderId, required this.cubit});

  final int workOrderId;
  final WorkOrderCubit cubit;

  @override
  State<_AttachFilesSheet> createState() => _AttachFilesSheetState();
}

class _AttachFilesSheetState extends State<_AttachFilesSheet> {
  final _notesController = TextEditingController();
  XFile? _image;
  String? _type;
  bool _isLoading = false;

  static const _typeValues = ['before', 'after', 'general'];
  static const _typeLabels = ['Before', 'After', 'General'];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (picked != null) setState(() => _image = picked);
  }

  void _showSourcePicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _upload() async {
    if (_image == null || _type == null) return;
    setState(() => _isLoading = true);
    final notes = _notesController.text.trim();
    final result = await serviceLocator<WorkOrdersService>().uploadAttachment(
      workOrderId: widget.workOrderId,
      type: _type!,
      image: _image!,
      notes: notes.isEmpty ? null : notes,
    );
    if (!mounted) return;
    if (result.response == ResponseEnum.success) {
      Navigator.of(context).pop();
      widget.cubit.refresh(widget.workOrderId);
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canUpload = _image != null && _type != null && !_isLoading;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, 8, 24, MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attach Files',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 24),

          // Image picker / preview area
          GestureDetector(
            onTap: _isLoading ? null : _showSourcePicker,
            child: Container(
              height: _image == null ? 140 : null,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAlias,
              child: _image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate_outlined,
                            size: 40, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        Text(
                          'Tap to select image',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Image.file(
                          File(_image!.path),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: _isLoading ? null : _showSourcePicker,
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.edit, color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 16),

          // Type dropdown
          DropdownButtonFormField<String>(
            initialValue: _type,
            decoration: const InputDecoration(
              labelText: 'Attachment Type',
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              _typeValues.length,
              (i) => DropdownMenuItem(value: _typeValues[i], child: Text(_typeLabels[i])),
            ),
            onChanged: _isLoading ? null : (v) => setState(() => _type = v),
          ),
          const SizedBox(height: 12),

          // Notes (optional)
          TextFormField(
            controller: _notesController,
            enabled: !_isLoading,
            maxLines: 2,
            minLines: 1,
            decoration: const InputDecoration(
              labelText: 'Notes (optional)',
              hintText: 'Add a note about this attachment…',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: canUpload ? _upload : null,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.upload_rounded),
              label: const Text('Upload'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCommentSheet extends StatefulWidget {
  const _AddCommentSheet({required this.workOrderId, required this.cubit});

  final int workOrderId;
  final WorkOrderCubit cubit;

  @override
  State<_AddCommentSheet> createState() => _AddCommentSheetState();
}

class _AddCommentSheetState extends State<_AddCommentSheet> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final result = await serviceLocator<WorkOrdersService>().createComment(
      workOrderId: widget.workOrderId,
      comment: _controller.text.trim(),
    );
    if (!mounted) return;
    if (result.response == ResponseEnum.success) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
      widget.cubit.refresh(widget.workOrderId);
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 8, 24, MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Comment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            TextFormField(
              controller: _controller,
              enabled: !_isLoading,
              maxLines: 5,
              minLines: 3,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: 'Write your comment here…',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (v) => valdiator(
                input: v,
                label: 'Comment',
                isRequired: true,
                minChars: 3,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompleteWorkOrderSheet extends StatelessWidget {
  const _CompleteWorkOrderSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complete Work Order',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 24),
          Center(
            child: Text(
              'TODO: Completion workflow',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
