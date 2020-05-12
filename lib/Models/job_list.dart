import 'package:shutz_ui/Models/user.dart';

class Job_list
{
  String job_id;
  String job_title;
  String loc;
  String provider_phone;
  String provider_id;
  String provider_msg;
  String provider_name;
  String provider_pic;
  String time;

  Job_list({
    this.job_id,
    this.job_title,
    this.loc,
    this.provider_id,
    this.provider_msg,
    this.provider_name,
    this.provider_phone,
    this.provider_pic,
    this.time
  });

  Job_list buildjob(User user,String msg,String title)
  {
    return  user != null?Job_list(
  provider_id: user.uid,
  provider_phone:user.phone,
  provider_pic: user.pic,
  provider_name: user.name,
  provider_msg: msg, 
  loc: null,
  time:  DateTime.now().millisecondsSinceEpoch.toString(),
  job_title: title,
  job_id: DateTime.now().millisecondsSinceEpoch.toString()+user.uid)
  :null;}
}