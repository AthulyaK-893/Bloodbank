import 'package:blood_dontaion_app/sheetscolumn.dart';
import 'package:gsheets/gsheets.dart';

class SheetsBloodDonation{
  static String _sheetId="15UbjisuVvvtFFi4L7o9NepRPQKf-JEghduz6Jy8bL-8";
  static const _sheetCredentials=r'''{
  "type": "service_account",
  "project_id": "bloodbank-93d85",
  "private_key_id": "18d9fefeba842085e4f42f2605c72e2b5e85c745",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCoI66JluFVIMfS\ns4EaLL+ebYQHw0lcz5SKLa+SN/nqFjDUfj/L/Tgh0N5vaYsXqZ23zH6IIFp8x2ju\nQbqwI/7SVr5429QzKvh3V+N6m/GR3DllsHaBWg2Zu16QeTXTGIvD7uJCfidC6Uyr\nPEQdwDwEaYaqJsyRzT+Mv4AF315sGD9WGUpyDdHy/0ImPDaYccHnzHoOH6jD5xTO\nhZFyUMFAdy4tXKLnTccLwt0l4maD28mgu0xNYdemdLDC5jY/lStLzO9od5XDjrlj\npmma7ZsD69qbZ7kCQI02pZz5YSFB8qStW31mTQM3gIoabfd8gNt3yPlaQS032J/N\n2RrNmP/7AgMBAAECggEASr1xvF+BUqH7sUFxxfzWQMpVwk2gsszjLnkYblrLkK7E\njfCA02CALyf1eHjmB2KyZR1VsZUQJB9QGXjGT73wa/d7O6YcMZKMWCCNUdc4Dqpi\nKT3Dr8Qj/442fuoibu+eUT5C/WOueCPUnNlxPfhRtXRjFAejL7yY3yvQ8MtV4Z49\nHZfHVKr/16BujWoVQEXgy5pa4hIF7fpuDNVKHKkT9ubQzn+N+cDADLcCLzVktsZ3\nD0WbYcv335ZeemLITJUKOX94XgsHL9XtUdPRqKg80UMB7mSZ3jszgZP9aD8STt/e\nTvgxIfPY1Cr+rnJpN+5eKK6ouAwKDu8LGMbP/kAegQKBgQDWTvlSXuJlrSO/P7nf\nMPliKa9X/rmvgOk0DGZW1fRkf2wLoZx2n07umMvHPDhJIVLf8wbM79Y3yFO1Ytx8\nhJbict/vrqFd85yuTeTXpVdRhXAlId7oVkYxCtQkk8Th2yngj70YpQxfYDYz+RhX\nhaDw0gXkT3FdCt0NucRhga6W6wKBgQDI2WLsHq2vhw8Xx/U5eHSagEGz5Sy/uHYF\niDM0IECEi2EvgTzP3AZaEhld6pUGdyPf5DenwibDcZmZi4sFIi7WciGaRMqbizd9\ngGRtHhlHjDGDeogTHcAQxE4NU63w5Md0gqdtIxE7nrwp0/59dhZhmsm2msfrxxt4\nI5nC2R0XMQKBgDjdr86pms18CdY/pKSSrDnd8ccZsk/dlwPWnnlAQJ9CKHtVoNzh\nHOK27KurUQwmqYT/Sbirk14t6/hfiT4JOLhR3xYMcokpkVO3G5gVKXxaOg3AVRO1\ngN6WjwA9rap4qz4JJhYaBZRxRTC5Ujo3HSOJt0KDygL0VP/FYVS2QouNAoGAcHFT\nckFSl1wTVQr6/Ku1C/IV1nLM9KB+YmZ31AziUdH+HKxLsUrKu446aVu1BqOYj/Wi\nOub08KIejdmTgNI8So4mxckRbLcp37cLghNBr86KwcLNf3Y+WqSr1cYtMRnDmDS1\nKuJg+XHKgdhPN0nvCcGwf+xzVEpp1H6JzI3kPWECgYEAnayzYJewtWPavotVXo2w\nd91Ain6Ne/GTUCatawxBzUkoJmrmHIuAX9dKxLsNK5LY1S4BLM+rVhw4vLK2xqKh\nZKGh2DGjsc8IaEx1q3cbE9D9opsLGvqNcLP5255A1zzC1U2rX+2dZrYqBc0DBH2G\nkCNLrG1kGMl/ViRIpxmfqo8=\n-----END PRIVATE KEY-----\n",
  "client_email": "blooddonation@bloodbank-93d85.iam.gserviceaccount.com",
  "client_id": "117647116633365754572",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/blooddonation%40bloodbank-93d85.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

static Worksheet? _userSheet;
static final _gsheets=GSheets(_sheetCredentials);

static Future init()async{
  try{
    final spreadsheet=await _gsheets.spreadsheet(_sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: "Feed");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
  }catch(e){
 print(e);
  }
}

static Future<Worksheet>_getWorkSheet(
  Spreadsheet spreadsheet,{
   required String title,
  }
)async{
  try{
return await spreadsheet.addWorksheet(title);
  }catch(e){
return spreadsheet.worksheetByTitle(title)!;
  }
}
  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}