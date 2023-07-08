part of 'certificate_cubit.dart';

abstract class CertificateState {}

class CertificateInitial extends CertificateState {
  final List<File> certificates;

  CertificateInitial({required this.certificates});
}
