import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:passwd_manager_client/constants.dart';

class Body{
  final Map<String, String> _body = <String, String>{};
  late final Instruction _instruction;
  Instruction get instruction => _instruction;

  Body(Instruction instruction, {String? clientSecret}){
    if(instruction != Instruction.init){
      if(clientSecret == null){
        throw Exception("Client Secret is null, but needed for instruction ${instruction.name}");
      }
      _body["clientSecret"] = clientSecret;
    }

    _body["instruction"] = instruction.name;
    _instruction = instruction;
  }

  void addArgument(String key, String value){
    if(key == "clientSecret" || key == "instruction"){
      throw Exception("Argument $key is not allowed");
    }
    _body[key] = value;
  }

  Map<String, String> getBody(){
    return _body;
  }
}

enum Rights implements Comparable<Rights>{
  root(level: 3),
  admin(level: 2),
  client(level: 1),
  everyone(level: 0);

  const Rights({
    required this.level,
  });

  final int level;

  @override
  int compareTo(Rights other) {
    return level.compareTo(other.level);
  }
}

enum Instruction{
  glog("GLOG", right: Rights.root),   //gets filtered logs from the server
  gcal("GCAL", right: Rights.root),   //gets filtered information about client calls to the server
  degc("DEGC", right: Rights.root),   //degrades an Admin to a normal client
  upgc("UPGC", right: Rights.root),   //upgrades a normal client to an admin
  up("UP", right: Rights.root),       //undo a DOWN call
  time("TIME", right: Rights.root),   //sets a timeout for an instruction for a group
  maxc("MAXC", right: Rights.root),   //sets a maximum number of calls per time (day?)

  auth("AUTH", right: Rights.admin),  //gets an auth code to validate a new client
  infc("INFC", right: Rights.admin),  //all client information except secrets	(client id, name, rights, calls, etc.)
  infu("INFU", right: Rights.admin),  //all user information (names, space, used space, calls, etc)
  rmvc("RMVC", right: Rights.admin),  //removes a normal client
  shut("SHUT", right: Rights.admin),  //server will only handle WAKE or instructions from Root for [time]
  down("DOWN", right: Rights.admin),  //server will only handle instructions from root
  wake("WAKE", right: Rights.admin),  //server will be online again (not after a DOWN call)

  //ok("OK", right: Rights.client),     //executes the last sent call (with call secret)
  //isok("ISOK", right: Rights.client), //checks if the last call was successful (if the call queue is empty)
  //retr("RETR", right: Rights.client), //gets information about the last call if its supported (does need the last call secret)
  ping("PING", right: Rights.client), //pings server, can be used to enable client
  clog("CLOG", right: Rights.client), //gets call logs from the client (and if these were successful)
  addu("ADDU", right: Rights.client), //adds a new user with name to the client
  rmvu("RMVU", right: Rights.client), //deletes user (with all data). User has to be on the client
  setu("SETU", right: Rights.client), //adds a known user to the client if password is correct
  cinf("CINF", right: Rights.client), //information about client (client id, rights, (available) calls, etc.)
  uinf("UINF", right: Rights.client), //information about the client users (names, space, used space, (available) calls, etc)
  gfn("GFN", right: Rights.client),   //gets stored file names
  gf("GF", right: Rights.client),     //gets decrypted file
  sf("SF", right: Rights.client),     //stores file encrypted in server
  rmvf("RMVF", right: Rights.client), //deletes a stored file
  mf("MF", right: Rights.client),     //GF + RMVF
  gs("GS", right: Rights.client),     //gets the special file information and shows them in the app
  cs("CS", right: Rights.client),     //changes the special file with new data

  init("INIT", right: Rights.everyone); //Adds device as new client

  const Instruction(this.name, {
    required this.right,
  });
  final Rights right;
  final String name;

}

class Server{
  static const String _ip = "127.0.0.1";
  static const int _port = 8080;
  static final Uri _url = Uri.http("$_ip:$_port");
  late String _clientSecret;

  void readSecrets(){
    //TODO
    _clientSecret = "clientSecret";
  }
  
  void writeSecrets(){
    //TODO
  }

  Server(){
    readSecrets();
  }

  Future<int> requestINIT({required String authCode}) async{
    Body body = Body(Instruction.init);
    body.addArgument("authCode", authCode);
    //client secret is not needed for init because we do not have if yet
    Map<String, String> resp = await request(body);
    _clientSecret = resp["clientSecret"]!;
    writeSecrets();

    int resp2 = await requestPING();
    return resp2;
  }

  Future<int> requestPING([int iters = 3]) async{
    int ping = 0;
    for(int i = 0; i < iters; i++){
      DateTime now = DateTime.now();
      await request(Body(Instruction.ping, clientSecret: _clientSecret));
      ping += (DateTime.now().difference(now)).inMilliseconds;
    }
    return ping ~/ iters;
  }

  Future<Map<String, String>> request(Body body) async{
    http.Response response;
    try{
    response = await http.post(_url, body: body.getBody())
      .timeout(const Duration(seconds: SERVER_TIMEOUT_SECONDS), onTimeout: ()=> http.Response("Timeout", 900));
    }catch(e){
      //TODO
      response = http.Response(e.toString(), 901);
    }
    // Errorhandling
    Map<String, String> map = {};
    switch (response.statusCode){
      case 200:
        map["requestError"] = "false";
      case 900:
        map["requestError"] = "Server Timeout";
        return map;
      case 901:
        map["requestError"] = response.body;
        return map;
      case 400:
        map["requestError"] = "Bad Request";
        return map;
      case 401:
        map["requestError"] = "Unauthorized";
        return map;
      case 403:
        map["requestError"] = "Forbidden";
        return map;
      case 404:
        map["requestError"] = "Not Found";
        return map;
      case 500:
        map["requestError"] = "Internal Server Error";
        return map;
      case 501:
        map["requestError"] = "Not Implemented";
        return map;
      case 502:
        map["requestError"] = "Bad Gateway";
        return map;
      case 503:
        map["requestError"] = "Service Unavailable";
        return map;
      case 504:
        map["requestError"] = "Gateway Timeout";
        return map;
      default:
        map["requestError"] = "Unknown Error ${response.statusCode}";
        return map;
    }
    
    response.body.split("\n").forEach((element) {
      if(element == "") return;
      List<String> split = element.split(":::");
      if(split.length == 2){
        map[split[0]] = split[1];
      }else{
        map["requestError"] = "Wrong Response Format";
      }
    });
    return map;
  }
}

//Future<Map<String, String>> fullRequest(Header header, Body body) async{
  //   if(header.getHeaders()["clientSecret"] == null || header.getHeaders()["callSecret"] == null){
  //     return <String, String>{
  //       "requestError": "true",
  //       "requestErrorLevel1": "No client or call secret given",
  //     };
  //   }
  //   Map<String, String> response = await request(header, body);
  //   if(response["requestError"] != "false"){
  //     response["requestErrorLevel1"] = "No call made";
  //     return response;
  //   }
  //   String? newCallSecret = response["callSecret"];
  //   if(newCallSecret == null){
  //     response["requestErrorLevel1"] = "No call secret returned";
  //     return response;
  //   }
  //   Body body2 = Body();
  //   body2.addArgument("callSecret", newCallSecret);
  //   Map<String, String> execResponse = {};
  //   execResponse = await request(Header(Instruction.ok, clientSecret: header.getHeaders()["clientSecret"]!, callSecret: header.getHeaders()["callSecret"]!), body2);
  //   execResponse["newCallSecret"] = newCallSecret;
  //   if(execResponse["requestError"] != "false"){
  //     execResponse["requestErrorLevel1"] = "Call made, but not safely executed";
  //   }
  //   return execResponse;
  // }