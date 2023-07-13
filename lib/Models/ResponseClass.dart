class ResponseClass<T> {
  String msg;
  bool success;
  T? data;
  ResponseClass({required this.msg,required this.success,this.data});
}