import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/service_detail_request/service_detail_request_bloc.dart';
import 'package:ssc/domain/model/service_entity.dart';
import 'package:ssc/presentation/customer/service_detail/video_record_page.dart';
import 'package:ssc/presentation/utils/common/custom_snackbar.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class ServiceDetailPage extends StatefulWidget {
  final ServiceEntity serviceEntity;
  const ServiceDetailPage({super.key, required this.serviceEntity});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  late TextEditingController _noteController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
    _focusNode.dispose();
  }

  void goToVideoRecorder() async {
    final cameras = await availableCameras();
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoRecorderScreen(cameras: cameras)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Service detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.serviceEntity.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 6.0.h,
              ),
              Text(
                widget.serviceEntity.description,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 12.0.h,
              ),
              ExpansionTile(
                initiallyExpanded: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                collapsedBackgroundColor:
                    Colors.orange.shade100.withOpacity(0.6),
                backgroundColor: Colors.orange.shade100.withOpacity(0.2),
                tilePadding: EdgeInsets.zero,
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const Text(
                    'Raise your Request',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                ),
                childrenPadding: EdgeInsets.symmetric(horizontal: 8),
                children: [
                  SizedBox(
                    height: 6.0.h,
                  ),
                  TextField(
                    controller: _noteController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Enter your request here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        String note = _noteController.text;

                        FocusScope.of(context).requestFocus(FocusNode());
                        context.read<ServiceDetailRequestBloc>().add(
                            ServiceDetailRequestSetNoteEvent(
                                requestNote: note));
                        CustomSnackbar.showSuccessMessage(
                            context, 'Note saved successfully');
                      },
                      child: const Text('SAVE'),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0.h),
              Center(
                child: const Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10.0.h),
              ExpansionTile(
                initiallyExpanded: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                collapsedBackgroundColor:
                    Colors.orange.shade100.withOpacity(0.6),
                backgroundColor: Colors.orange.shade100.withOpacity(0.2),
                tilePadding: EdgeInsets.zero,
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const Text(
                    'Raise your Request',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                ),
                children: [
                  BlocBuilder<ServiceDetailRequestBloc,
                      ServiceDetailRequestBlocState>(
                    buildWhen: (previous, current) =>
                        previous.serviceEntity.videoFile !=
                        current.serviceEntity.videoFile,
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => goToVideoRecorder(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orange.shade100.withOpacity(0.6),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 6),
                          child: state.isVideoFileEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: const Text(
                                        'Record Video',
                                        style: TextStyle(
                                            // fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0.w,
                                    ),
                                    IconButton(
                                      onPressed: () => goToVideoRecorder(),
                                      icon: Icon(
                                        Icons.videocam,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Text(
                                      'Video file',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.play_arrow,
                                      size: 24,
                                    ),
                                    IconButton(
                                      onPressed: () => context
                                          .read<ServiceDetailRequestBloc>()
                                          .add(
                                              ServiceDetailRequestDeleteEvent()),
                                      icon: Icon(
                                        Icons.delete,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // Center(
              //   child: const Text(
              //     'We allow customer to record there request',
              //     style: TextStyle(
              //         // fontSize: 16,
              //         fontWeight: FontWeight.w500),
              //   ),
              // ),
              SizedBox(height: 2.0.h),

              SizedBox(height: 20.0.h),
              BlocBuilder<ServiceDetailRequestBloc,
                  ServiceDetailRequestBlocState>(
                buildWhen: (previous, current) =>
                    previous.serviceEntity.videoFile !=
                    current.serviceEntity.videoFile,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        if (_noteController.text.isEmpty ||
                            state.isVideoFileEmpty) {
                          CustomSnackbar.showErrorMessage(
                              context, 'Please add at least one request');
                        }
                        FocusScope.of(context).requestFocus(FocusNode());
                        context.read<ServiceDetailRequestBloc>().add(
                            ServiceDetailRequestSetNoteEvent(
                                requestNote: _noteController.text));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.orange.shade300),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orange.shade100.withOpacity(0.6),
                          ),
                          child: const Text(
                            'Submit request',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
