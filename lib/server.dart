import 'package:http/http.dart' as http;

class Header{
  final Map<String, String> _header = <String, String>{};

  Header(Instruction instruction, {String? clientSecret, String? callSecret}){
    if(instruction != Instruction.init){
      if(clientSecret == null){
        throw Exception("Client Secret is null, but needed for instruction ${instruction.name}");
      }
      if(callSecret == null){
        throw Exception("Call Secret is null, but needed for instruction ${instruction.name}");
      }
      _header["clientSecret"] = clientSecret;
      _header["callSecret"] = callSecret;
    }

    _header["instruction"] = instruction.name;
  }

  Map<String, String> getHeaders(){
    return _header;
  }

}

class Body{
  Map<String, String> _body = <String, String>{};

  void addArgument(String key, String value){
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

  ok("OK", right: Rights.client),     //executes the last sent call (with call secret)
  ping("PING", right: Rights.client), //pings server, can be used to enable client
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
  final Uri _url = Uri.http("$_ip:$_port");

  Future<String> request(Header header, Body body) async{
    var response = await http.post(_url, headers: header.getHeaders(), body: body.getBody());
    // Errorhandling
    switch (response.statusCode){
      case 200:
        break;
      case 400:
        throw Exception("Bad Request");
      case 401:
        throw Exception("Unauthorized");
      case 403:
        throw Exception("Forbidden");
      case 404:
        throw Exception("Not Found");
      case 500:
        throw Exception("Internal Server Error");
      case 501:
        throw Exception("Not Implemented");
      case 502:
        throw Exception("Bad Gateway");
      case 503:
        throw Exception("Service Unavailable");
      case 504:
        throw Exception("Gateway Timeout");
      default:
        throw Exception("Unknown Error Code: ${response.statusCode}");
    }
    return response.body;
  }
}