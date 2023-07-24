import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:bloc/bloc.dart';

part 'certificate_state.dart';

class CertificateCubit extends Cubit<CertificateState> {
  List<File> certificates = [];
  CertificateCubit() : super(CertificateInitial(certificates: []));
  Future<void> certificatePicking() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result != null) {
      certificates.addAll(result.paths.map((path) => File(path!)).toList());
      emit(CertificateInitial(certificates: certificates));
    }
  }
}
